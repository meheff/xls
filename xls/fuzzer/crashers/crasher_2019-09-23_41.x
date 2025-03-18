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
// BEGIN_CONFIG
// sample_options {
//   input_is_dslx: true
//   sample_type: SAMPLE_TYPE_FUNCTION
//   ir_converter_args: "--top=main"
//   convert_to_ir: true
//   optimize_ir: true
//   use_jit: true
//   codegen: true
//   codegen_args: "--generator=pipeline"
//   codegen_args: "--pipeline_stages=3"
//   codegen_args: "--reset_data_path=false"
//   simulate: false
//   use_system_verilog: true
//   calls_per_sample: 1
// }
// inputs {
//   function_args {
//     args: "bits[1]:0x0; bits[63]:0x1; bits[51]:0x200000000"
//   }
// }
// END_CONFIG
fn main(x283: bool, x284: u63, x285: u51) -> u51 {
    let x286: u51 = one_hot_sel(x283, [x285]);
    x286
}
