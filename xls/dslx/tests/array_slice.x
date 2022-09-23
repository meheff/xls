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

fn main() -> s32[3] {
  slice(s32[8]:[1, 2, 3, 4, 5, 6, 7, 8], u32:2, s32[3]:[0, 0, 0])
}

#[test]
fn test_concat() {
  assert_eq(s32[3]:[3, 4, 5], main())
}
