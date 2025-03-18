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

fn checked_divide(x: u32, y: u32) -> u32 {
    match y {
        u32:1 => x,
        u32:0 => fail!("y_is_zero", u32:0),
        _ => x / y,
    }
}

const THREE = checked_divide(u32:6, u32:2);

fn main() -> u32 {
    // TODO(https://github.com/google/xls/issues/496) 2021-09-16:
    // Replace with three + three when the issue is fixed.
    u32:3 + u32:3
}

#[test]
fn compute_without_fail_test() { assert_eq(u32:3, THREE); }
