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

#include "llvm/include/llvm/Support/LogicalResult.h"
#include "mlir/include/mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/include/mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/include/mlir/Dialect/Math/IR/Math.h"
#include "mlir/include/mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/include/mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/include/mlir/Pass/PassRegistry.h"
#include "mlir/include/mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/include/mlir/Transforms/Passes.h"
#include "xls/contrib/mlir/IR/register.h"
#include "xls/contrib/mlir/IR/xls_ops.h"  // IWYU pragma: keep
#include "xls/contrib/mlir/transforms/passes.h"
#include "xls/contrib/mlir/transforms/xls_lower.h"
#include "xls/contrib/mlir/util/extraction_utils.h"
#include "xls/contrib/mlir/util/proc_utils.h"

int main(int argc, char** argv) {
  mlir::DialectRegistry registry;
  registry.insert<mlir::arith::ArithDialect, mlir::func::FuncDialect,
                  mlir::math::MathDialect, mlir::scf::SCFDialect,
                  mlir::tensor::TensorDialect>();
  mlir::xls::registerXlsDialect(registry);
  mlir::registerCanonicalizerPass();
  mlir::registerCSEPass();
  mlir::registerSymbolDCEPass();
  mlir::registerPass(mlir::xls::createScalarizePass);
  mlir::registerPass(mlir::xls::createArithToXlsPass);
  mlir::registerPass(mlir::xls::createScfToXlsPass);
  mlir::registerPass(mlir::xls::createNormalizeXlsCallsPass);
  mlir::registerPass(mlir::xls::createLowerCountedForPass);
  mlir::xls::registerXlsTransformsPasses();
  mlir::xls::RegisterXlsLowerPassPipeline();
  mlir::xls::test::registerTestExtractAsTopLevelModulePass();
  mlir::xls::test::registerTestConvertForOpToSprocCallPass();
  return failed(
      mlir::MlirOptMain(argc, argv, "MLIR XLS pass driver\n", registry));
}
