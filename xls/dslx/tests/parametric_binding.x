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

fn add_num_bits<N: u32>(x: bits[N]) -> bits[N] { x + (N as bits[N]) }

#[test]
fn different_parametric_invocations_test() { assert_eq(bits[2]:3, add_num_bits(bits[2]:1)) }
