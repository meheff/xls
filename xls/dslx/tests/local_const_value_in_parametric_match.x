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

// Parametric identity function.
fn id<N: u32>() -> u32 { N }

fn p<N: u32>(x: u32) -> bool {
    const M = id<N>() + u32:1;
    match x {
        M => true,
        N => true,
        _ => false,
    }
}

fn main() -> (bool, bool, bool) {
    let first = p<u32:42>(u32:42);
    let second = p<u32:42>(u32:43);
    let third = p<u32:42>(u32:44);
    (first, second, third)
}

#[test]
fn test_main() { assert_eq((true, true, false), main()) }
