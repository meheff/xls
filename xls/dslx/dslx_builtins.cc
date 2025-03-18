// Copyright 2020 The XLS Authors
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

#include "xls/dslx/dslx_builtins.h"

#include <cstdint>
#include <string>
#include <string_view>

#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "absl/strings/str_format.h"

namespace xls::dslx {

absl::StatusOr<Builtin> BuiltinFromString(std::string_view name) {
#define TRY_NAME(__name, __enum) \
  if (name == __name) {          \
    return Builtin::__enum;      \
  }
  XLS_DSLX_BUILTIN_EACH(TRY_NAME)
#undef TRY_NAME
  return absl::InvalidArgumentError(
      absl::StrFormat("Name is not a DSLX builtin: \"%s\"", name));
}

std::string BuiltinToString(Builtin builtin) {
  switch (builtin) {
#define CASIFY(__str, __enum) \
  case Builtin::__enum:       \
    return __str;
    XLS_DSLX_BUILTIN_EACH(CASIFY)
#undef CASIFY
  }
  return absl::StrFormat("<invalid Builtin(%d)>",
                         static_cast<int64_t>(builtin));
}

}  // namespace xls::dslx
