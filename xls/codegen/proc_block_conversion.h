// Copyright 2021 The XLS Authors
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

#ifndef XLS_CODEGEN_PROC_BLOCK_CONVERSION_H_
#define XLS_CODEGEN_PROC_BLOCK_CONVERSION_H_

#include "absl/base/nullability.h"
#include "absl/status/status.h"
#include "xls/codegen/codegen_options.h"
#include "xls/codegen/codegen_pass.h"
#include "xls/ir/block.h"
#include "xls/ir/proc.h"
#include "xls/scheduling/pipeline_schedule.h"

namespace xls::verilog {
// Converts a proc into a pipelined block.
//
// Parameters:
//  input - schedule: Schedule for the to-be-created block.
//  input - options:  Codegen options.
//  inout - unit:     Metadata for codegen passes.
//  input - proc:     Function to convert to a pipelined block.
//  inout - block:    Destination block, should be empty.
absl::Status SingleProcToPipelinedBlock(const PipelineSchedule& schedule,
                                        const CodegenOptions& options,
                                        CodegenPassUnit& unit, Proc* proc,
                                        absl::Nonnull<Block*> block);

}  // namespace xls::verilog
#endif  // XLS_CODEGEN_PROC_BLOCK_CONVERSION_H_
