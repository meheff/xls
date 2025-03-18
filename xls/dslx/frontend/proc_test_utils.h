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

#ifndef XLS_DSLX_FRONTEND_PROC_TEST_UTILS_H_
#define XLS_DSLX_FRONTEND_PROC_TEST_UTILS_H_

#include <string_view>
#include <utility>

#include "xls/dslx/frontend/module.h"
#include "xls/dslx/frontend/pos.h"
#include "xls/dslx/frontend/proc.h"

namespace xls::dslx {

// Creates an empty proc with the given name, in a dedicated module. This is
// useful for tests that need to deal with `Proc` objects as black-box entities
// with irrelevant content.
std::pair<Module, Proc*> CreateEmptyProc(FileTable& file_table,
                                         std::string_view name);

}  // namespace xls::dslx

#endif  // XLS_DSLX_FRONTEND_PROC_TEST_UTILS_H_
