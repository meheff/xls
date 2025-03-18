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

#include "xls/estimators/area_model/area_estimators.h"

#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "absl/status/status_matchers.h"
#include "xls/common/status/matchers.h"
#include "xls/estimators/area_model/area_estimator.h"
#include "xls/ir/function_builder.h"
#include "xls/ir/ir_test_base.h"

namespace xls {
namespace {

using ::absl_testing::IsOkAndHolds;

class DelayEstimatorsTest : public IrTestBase {};

TEST_F(DelayEstimatorsTest, UnitDelayModel) {
  XLS_ASSERT_OK_AND_ASSIGN(AreaEstimator * estimator, GetAreaEstimator("unit"));
  auto p = CreatePackage();
  FunctionBuilder fb(TestName(), p.get());
  BValue x = fb.Param("x", p->GetBitsType(32));
  BValue add = fb.Add(x, x);
  BValue negate = fb.Negate(x);
  BValue mul = fb.UMul(x, x);
  BValue and_op = fb.And(x, x);
  BValue tuple = fb.Tuple({x, add, mul});

  EXPECT_THAT(estimator->GetOperationAreaInSquareMicrons(x.node()),
              IsOkAndHolds(0));
  EXPECT_THAT(estimator->GetOperationAreaInSquareMicrons(add.node()),
              IsOkAndHolds(1));
  EXPECT_THAT(estimator->GetOperationAreaInSquareMicrons(negate.node()),
              IsOkAndHolds(1));
  EXPECT_THAT(estimator->GetOperationAreaInSquareMicrons(mul.node()),
              IsOkAndHolds(1));
  EXPECT_THAT(estimator->GetOperationAreaInSquareMicrons(and_op.node()),
              IsOkAndHolds(1));
  EXPECT_THAT(estimator->GetOperationAreaInSquareMicrons(tuple.node()),
              IsOkAndHolds(1));
}

}  // namespace
}  // namespace xls
