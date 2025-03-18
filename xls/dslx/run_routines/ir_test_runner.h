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

#ifndef XLS_DSLX_RUN_ROUTINES_IR_TEST_RUNNER_H_
#define XLS_DSLX_RUN_ROUTINES_IR_TEST_RUNNER_H_

#include <memory>

#include "absl/status/statusor.h"
#include "xls/dslx/frontend/module.h"
#include "xls/dslx/import_data.h"
#include "xls/dslx/run_routines/run_routines.h"
#include "xls/dslx/type_system/type_info.h"

namespace xls::dslx {

class IrInterpreterTestRunner : public AbstractTestRunner {
 protected:
  absl::StatusOr<std::unique_ptr<AbstractParsedTestRunner>> CreateTestRunner(
      ImportData* import_data, TypeInfo* type_info,
      Module* module) const override;
};

class IrJitTestRunner : public AbstractTestRunner {
 protected:
  absl::StatusOr<std::unique_ptr<AbstractParsedTestRunner>> CreateTestRunner(
      ImportData* import_data, TypeInfo* type_info,
      Module* module) const override;
};

}  // namespace xls::dslx

#endif  // XLS_DSLX_RUN_ROUTINES_IR_TEST_RUNNER_H_
