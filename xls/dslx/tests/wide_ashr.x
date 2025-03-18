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

#[test]
fn simple_add_test() {
    let x: sN[80] = sN[80]:0x8000_0000_0000_0000_0000 >> uN[80]:0x0aaa_bbbb_cccc_dddd_eeee;
    assert_eq(sN[80]:0xffff_ffff_ffff_ffff_ffff, x)
}
