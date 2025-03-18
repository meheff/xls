// RUN: xls_opt -normalize-xls-calls %s 2>&1 | FileCheck %s

// CHECK: xls.import_dslx_file_package "xls/contrib/mlir/testdata/i32/dot_product.x" as @dot_product
// CHECK: func.func private @dot_product_dot_product_fixed_test(!xls.array<4 x i32>, !xls.array<4 x i32>) -> i32 attributes {xls.linkage = {{.*}}<@dot_product : "dot_product_fixed_test">}
// CHECK: xls.import_dslx_file_package "xls/contrib/mlir/testdata/foo/dot_product.x" as @dot_product_0
// CHECK: func.func private @dot_product_dot_product_fixed_test_1(!xls.array<4 x i32>, !xls.array<4 x i32>) -> i32 attributes {xls.linkage = {{.*}}<@dot_product_0 : "dot_product_fixed_test">}

// CHECK-LABEL:   func.func @simple_call(
// CHECK-SAME:        %[[VAL_0:.*]]: !xls.array<4 x i32>, %[[VAL_1:.*]]: !xls.array<4 x i32>
// CHECK:           %[[VAL_2:.*]] = call @dot_product_dot_product_fixed_test(%[[VAL_0]], %[[VAL_1]])
// CHECK:           %[[VAL_3:.*]] = call @dot_product_dot_product_fixed_test_1(%[[VAL_0]], %[[VAL_1]])

// Note: The name below is subject to change. It is just testing that a template
// instantiation would get normalized. The name is not important.
// CHECK:           %[[VAL_4:.*]] = call @"dot_product_fn dot_product_fixed_test

// CHECK:           return %[[VAL_2]] : i32
func.func @simple_call(%arg0: !xls.array<4 x i32>, %arg1: !xls.array<4 x i32>) -> i32 {
  %0 = xls.call_dslx "xls/contrib/mlir/testdata/i32/dot_product.x":
    "dot_product_fixed_test"(%arg0, %arg1) : (!xls.array<4 x i32>, !xls.array<4 x i32>) -> i32
  %1 = xls.call_dslx "xls/contrib/mlir/testdata/foo/dot_product.x":
    "dot_product_fixed_test"(%arg0, %arg1) : (!xls.array<4 x i32>, !xls.array<4 x i32>) -> i32
  %2 = xls.call_dslx "xls/contrib/mlir/testdata/foo/dot_product.x":
    "fn dot_product_fixed_test(a : s32[4], b: s32[4]) -> s32 { dot_product_fixed<u32:32, u32:4>(a, b) }"
    (%arg0, %arg1) : (!xls.array<4 x i32>, !xls.array<4 x i32>) -> i32
  return %0 : i32
}
