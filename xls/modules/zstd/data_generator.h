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
//
#ifndef XLS_MODULES_ZSTD_DATA_GENERATOR_H_
#define XLS_MODULES_ZSTD_DATA_GENERATOR_H_

#include <cstdint>
#include <vector>

#include "absl/status/statusor.h"

namespace xls::zstd {

enum class BlockType {
  RAW,
  RLE,
  COMPRESSED,
  RANDOM,
};

absl::StatusOr<std::vector<uint8_t>> GenerateFrameHeader(int seed, bool magic);
absl::StatusOr<std::vector<uint8_t>> GenerateFrame(int seed, BlockType btype);

}  // namespace xls::zstd

#endif  // XLS_MODULES_ZSTD_DATA_GENERATOR_H_
