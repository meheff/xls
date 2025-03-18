// Copyright 2024 The XLS Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "xls/codegen/stage_conversion.h"

#include <cstdint>
#include <memory>
#include <string>
#include <string_view>
#include <vector>

#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "absl/log/check.h"
#include "absl/log/log.h"
#include "absl/status/statusor.h"
#include "absl/strings/str_format.h"
#include "xls/codegen/codegen_options.h"
#include "xls/common/logging/log_lines.h"
#include "xls/common/status/matchers.h"
#include "xls/estimators/delay_model/delay_estimator.h"
#include "xls/interpreter/channel_queue.h"
#include "xls/interpreter/evaluator_options.h"
#include "xls/interpreter/interpreter_proc_runtime.h"
#include "xls/interpreter/proc_runtime.h"
#include "xls/ir/bits.h"
#include "xls/ir/channel.h"
#include "xls/ir/function_builder.h"
#include "xls/ir/instantiation.h"
#include "xls/ir/ir_test_base.h"
#include "xls/ir/nodes.h"
#include "xls/ir/op.h"
#include "xls/ir/proc_elaboration.h"
#include "xls/ir/value.h"
#include "xls/ir/verifier.h"
#include "xls/scheduling/pipeline_schedule.h"
#include "xls/scheduling/run_pipeline_schedule.h"
#include "xls/scheduling/scheduling_options.h"

namespace xls::verilog {
namespace {

using ::testing::Optional;

class StageConversionTestBase : public IrTestBase {
 protected:
  // Creates a runtime for the given proc and the proc hierarchy beneath it.
  std::unique_ptr<ProcRuntime> CreateRuntime(
      Proc* top, const EvaluatorOptions& options = EvaluatorOptions()) const {
    return CreateInterpreterSerialProcRuntime(top, options).value();
  }

  CodegenOptions codegen_options() {
    return CodegenOptions().module_name(TestName());
  }
};

// Unit delay delay estimator.
class TestDelayEstimator : public DelayEstimator {
 public:
  TestDelayEstimator() : DelayEstimator("test") {}

  absl::StatusOr<int64_t> GetOperationDelayInPs(Node* node) const override {
    switch (node->op()) {
      case Op::kAfterAll:
      case Op::kMinDelay:
      case Op::kParam:
      case Op::kStateRead:
      case Op::kNext:
      case Op::kInputPort:
      case Op::kOutputPort:
      case Op::kLiteral:
      case Op::kBitSlice:
      case Op::kConcat:
      case Op::kTupleIndex:
      case Op::kReceive:
      case Op::kSend:
        return 0;
      default:
        return 1;
    }
  }
};

// Fixture to sweep pipeline stages.
class SweepPipelineStagesFixture : public StageConversionTestBase,
                                   public testing::WithParamInterface<int64_t> {
 public:
  static std::string PrintToStringParamName(
      const testing::TestParamInfo<ParamType>& info) {
    return absl::StrFormat("stage_count_%d", info.param);
  }

  int64_t GetStageCount() const { return GetParam(); }
};

TEST_P(SweepPipelineStagesFixture, TrivialPipelinedFunction) {
  auto p = CreatePackage();
  FunctionBuilder fb(TestName(), p.get());
  BValue x = fb.Param("x", p->GetBitsType(32));
  BValue y = fb.Param("y", p->GetBitsType(32));
  XLS_ASSERT_OK_AND_ASSIGN(
      Function * f,
      fb.BuildWithReturnValue(fb.Add(fb.Negate(fb.Not(fb.Add(x, y))), x)));

  XLS_ASSERT_OK_AND_ASSIGN(
      PipelineSchedule schedule,
      RunPipelineSchedule(
          f, TestDelayEstimator(),
          SchedulingOptions().pipeline_stages(GetStageCount())));

  VLOG(2) << "Starting Package";
  XLS_VLOG_LINES(2, p->DumpIr());

  StageConversionMetadata metadata;

  XLS_ASSERT_OK(SingleFunctionBaseToPipelinedStages(
      "top", schedule,
      CodegenOptions().flop_inputs(false).flop_outputs(true).clock_name("clk"),
      metadata));

  VLOG(2) << "Final Package";
  XLS_VLOG_LINES(2, p->DumpIr());

  // Get top-level proc and input/output channels.
  XLS_ASSERT_OK_AND_ASSIGN(ProcMetadata * top_metadata,
                           metadata.GetTopProcMetadata(f));
  Proc* top_proc = top_metadata->proc();

  XLS_ASSERT_OK_AND_ASSIGN(ChannelInterface * ch_x,
                           top_proc->GetReceiveChannelInterface("x"));
  XLS_ASSERT_OK_AND_ASSIGN(ChannelInterface * ch_y,
                           top_proc->GetReceiveChannelInterface("y"));
  XLS_ASSERT_OK_AND_ASSIGN(ChannelInterface * ch_out,
                           top_proc->GetSendChannelInterface("out"));

  // Assert that the same channels can be retreived from the metadata.
  XLS_ASSERT_OK_AND_ASSIGN(
      std::vector<SpecialUseMetadata*> x_metadata,
      top_metadata->FindSpecialUseMetadata(
          x.node(), SpecialUseMetadata::Purpose::kExternalInput));
  XLS_ASSERT_OK_AND_ASSIGN(
      std::vector<SpecialUseMetadata*> y_metadata,
      top_metadata->FindSpecialUseMetadata(
          y.node(), SpecialUseMetadata::Purpose::kExternalInput));
  XLS_ASSERT_OK_AND_ASSIGN(
      std::vector<SpecialUseMetadata*> out_metadata,
      top_metadata->FindSpecialUseMetadata(
          f->return_value(), SpecialUseMetadata::Purpose::kExternalOutput));

  ASSERT_EQ(ch_x, x_metadata[0]->GetReceiveChannelInterface());
  ASSERT_EQ(ch_y, y_metadata[0]->GetReceiveChannelInterface());
  ASSERT_EQ(ch_out, out_metadata[0]->GetSendChannelInterface());

  // Run a few values through the pipeline and verify the output.
  std::unique_ptr<ProcRuntime> runtime =
      CreateRuntime(top_proc, EvaluatorOptions().set_trace_channels(true));
  ChannelQueueManager& queue_manager = runtime->queue_manager();
  const ProcElaboration& elaboration = queue_manager.elaboration();

  ChannelInstance* ch_x_instance =
      elaboration.GetInstancesOfChannelInterface(ch_x).at(0);
  ChannelInstance* ch_y_instance =
      elaboration.GetInstancesOfChannelInterface(ch_y).at(0);
  ChannelInstance* ch_out_instance =
      elaboration.GetInstancesOfChannelInterface(ch_out).at(0);

  ChannelQueue& x_queue = queue_manager.GetQueue(ch_x_instance);
  ChannelQueue& y_queue = queue_manager.GetQueue(ch_y_instance);
  ChannelQueue& out_queue = queue_manager.GetQueue(ch_out_instance);

  XLS_ASSERT_OK(x_queue.Write(Value(UBits(0x1, 32))));
  XLS_ASSERT_OK(y_queue.Write(Value(UBits(0x2, 32))));

  XLS_ASSERT_OK(x_queue.Write(Value(UBits(0x10, 32))));
  XLS_ASSERT_OK(y_queue.Write(Value(UBits(0x20, 32))));

  XLS_ASSERT_OK(runtime->TickUntilOutput(
      {{ch_out_instance, 2}},
      /*max_ticks=*/GetStageCount() + x_queue.GetSize()));

  EXPECT_THAT(out_queue.Read(), Optional(Value(UBits(0x5, 32))));
  EXPECT_THAT(out_queue.Read(), Optional(Value(UBits(0x41, 32))));
}

INSTANTIATE_TEST_SUITE_P(TrivialPipelinedFunction, SweepPipelineStagesFixture,
                         testing::Values(1, 2, 3, 4),
                         SweepPipelineStagesFixture::PrintToStringParamName);

}  // namespace
}  // namespace xls::verilog
