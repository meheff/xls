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
//     args: "bits[10]:0xcc"
//   }
// }
// END_CONFIG
fn main(x79: u10) -> (u5, u5, u5, u5, u5, u5, u5) {
    let x80: u5 = (u5:0x2);
    let x81: u5 = (x80) << (x80);
    let x82: u5 = ((x79) as u5) + (x80);
    let x83: u5 = (x82) - (x80);
    let x84: u5 = !(x80);
    let x85: u5 = (x82) ^ (x82);
    (x84, x83, x81, x83, x83, x82, x80)
}
