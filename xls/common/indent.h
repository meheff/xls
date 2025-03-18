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

#ifndef XLS_COMMON_INDENT_H_
#define XLS_COMMON_INDENT_H_

#include <cstdint>
#include <string>
#include <string_view>

namespace xls {

constexpr int kDefaultIndentSpaces = 2;

// Indents every line in "text" by the given number of spaces.
std::string Indent(std::string_view text,
                   int64_t spaces = kDefaultIndentSpaces);

}  // namespace xls

#endif  // XLS_COMMON_INDENT_H_
