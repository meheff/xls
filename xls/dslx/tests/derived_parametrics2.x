// Copyright 2023 The XLS Authors
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

fn parametric<X: u32, Y: u32 = {X + X}, Z: u32 = {Y + u32:1}>(x: bits[X]) -> (u32, u32, u32) {
    (X, Y, Z)
}

#[test]
fn parametric_test() { assert_eq((u32:2, u32:4, u32:5), parametric(bits[2]:0)) }
