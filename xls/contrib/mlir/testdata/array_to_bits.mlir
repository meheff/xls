// RUN: xls_opt -array-to-bits -canonicalize %s 2>&1 | FileCheck %s

// NOTE: Assertions have been autogenerated by utils/generate-test-checks.py

// CHECK-LABEL:   func.func @signature(
// CHECK-SAME:                         %[[VAL_0:.*]]: i64) -> i64 attributes {xls = true} {
// CHECK:           %[[VAL_1:.*]] = "xls.constant_scalar"() <{value = 6 : i32}> : () -> i32
// CHECK:           %[[VAL_2:.*]] = "xls.constant_scalar"() <{value = 7 : i32}> : () -> i32
// CHECK:           %[[VAL_3:.*]] = xls.concat %[[VAL_2]], %[[VAL_1]] : (i32, i32) -> i64
// CHECK:           %[[VAL_4:.*]] = xls.bit_slice %[[VAL_0]] {start = 0 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_5:.*]] = xls.bit_slice %[[VAL_3]] {start = 0 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_6:.*]] = xls.add %[[VAL_4]], %[[VAL_5]] : i32
// CHECK:           %[[VAL_7:.*]] = xls.bit_slice %[[VAL_0]] {start = 1 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_8:.*]] = xls.bit_slice %[[VAL_3]] {start = 1 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_9:.*]] = xls.add %[[VAL_7]], %[[VAL_8]] : i32
// CHECK:           %[[VAL_10:.*]] = xls.concat %[[VAL_9]], %[[VAL_6]] : (i32, i32) -> i64
// CHECK:           return %[[VAL_10]] : i64
// CHECK:         }
func.func @signature(%arg0: !xls.array<2 x i32>) -> !xls.array<2 x i32> attributes {xls = true} {
  %0 = "xls.constant_scalar"() <{value = 6 : i32}> : () -> i32
  %1 = "xls.constant_scalar"() <{value = 7 : i32}> : () -> i32
  %2 = xls.array %0, %1 : (i32, i32) -> !xls.array<2 x i32>
  %3 = "xls.array_index_static"(%arg0) <{index = 0 : i64}> : (!xls.array<2 x i32>) -> i32
  %4 = "xls.array_index_static"(%2) <{index = 0 : i64}> : (!xls.array<2 x i32>) -> i32
  %5 = xls.add %3, %4 : i32
  %6 = "xls.array_index_static"(%arg0) <{index = 1 : i64}> : (!xls.array<2 x i32>) -> i32
  %7 = "xls.array_index_static"(%2) <{index = 1 : i64}> : (!xls.array<2 x i32>) -> i32
  %8 = xls.add %6, %7 : i32
  %9 = xls.array %5, %8 : (i32, i32) -> !xls.array<2 x i32>
  return %9 : !xls.array<2 x i32>
}

// CHECK-LABEL:   func.func @noarg() -> i64 attributes {xls = true} {
// CHECK:           %[[VAL_0:.*]] = "xls.constant_scalar"() <{value = 6 : i32}> : () -> i32
// CHECK:           %[[VAL_1:.*]] = "xls.constant_scalar"() <{value = 7 : i32}> : () -> i32
// CHECK:           %[[VAL_2:.*]] = xls.concat %[[VAL_1]], %[[VAL_0]] : (i32, i32) -> i64
// CHECK:           %[[VAL_3:.*]] = xls.bit_slice %[[VAL_2]] {start = 0 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_4:.*]] = xls.bit_slice %[[VAL_2]] {start = 0 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_5:.*]] = xls.add %[[VAL_3]], %[[VAL_4]] : i32
// CHECK:           %[[VAL_6:.*]] = xls.bit_slice %[[VAL_2]] {start = 1 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_7:.*]] = xls.bit_slice %[[VAL_2]] {start = 1 : i64, width = 32 : i64} : (i64) -> i32
// CHECK:           %[[VAL_8:.*]] = xls.add %[[VAL_6]], %[[VAL_7]] : i32
// CHECK:           %[[VAL_9:.*]] = xls.concat %[[VAL_8]], %[[VAL_5]] : (i32, i32) -> i64
// CHECK:           return %[[VAL_9]] : i64
// CHECK:         }
func.func @noarg() -> !xls.array<2 x i32> attributes {xls = true} {
  %0 = "xls.constant_scalar"() <{value = 6 : i32}> : () -> i32
  %1 = "xls.constant_scalar"() <{value = 7 : i32}> : () -> i32
  %2 = xls.array %0, %1 : (i32, i32) -> !xls.array<2 x i32>
  %3 = "xls.array_index_static"(%2) <{index = 0 : i64}> : (!xls.array<2 x i32>) -> i32
  %4 = "xls.array_index_static"(%2) <{index = 0 : i64}> : (!xls.array<2 x i32>) -> i32
  %5 = xls.add %3, %4 : i32
  %6 = "xls.array_index_static"(%2) <{index = 1 : i64}> : (!xls.array<2 x i32>) -> i32
  %7 = "xls.array_index_static"(%2) <{index = 1 : i64}> : (!xls.array<2 x i32>) -> i32
  %8 = xls.add %6, %7 : i32
  %9 = xls.array %5, %8 : (i32, i32) -> !xls.array<2 x i32>
  return %9 : !xls.array<2 x i32>
}

// CHECK-LABEL:   func.func @empty(
// CHECK-SAME:                     %[[VAL_0:.*]]: i64,
// CHECK-SAME:                     %[[VAL_1:.*]]: i32) -> i64 attributes {xls = true} {
// CHECK:           return %[[VAL_0]] : i64
// CHECK:         }
func.func @empty(%arg0: !xls.array<2 x i32>, %arg1: i32) -> !xls.array<2 x i32> attributes {xls = true} {
  return %arg0 : !xls.array<2 x i32>
}

// CHECK-LABEL:   func.func @tensor_insert(
// CHECK-SAME:                             %[[VAL_0:.*]]: i448,
// CHECK-SAME:                             %[[VAL_1:.*]]: i32) -> i448 attributes {xls = true} {
// CHECK:           %[[VAL_2:.*]] = "xls.constant_scalar"() <{value = 13 : index}> : () -> index
// CHECK:           %[[VAL_3:.*]] = "xls.bit_slice_update"(%[[VAL_0]], %[[VAL_2]], %[[VAL_1]]) : (i448, index, i32) -> i448
// CHECK:           return %[[VAL_3]] : i448
// CHECK:         }
func.func @tensor_insert(%arg0: !xls.array<14 x i32>, %arg1: i32) -> !xls.array<14 x i32> attributes {xls = true} {
  %c1 = arith.constant 1 : index
  %c6 = arith.constant 6 : index
  %c0 = arith.constant 0 : index
  %c1_0 = arith.constant 1 : index
  %0 = "xls.constant_scalar"() <{value = 6 : index}> : () -> index
  %1 = "xls.constant_scalar"() <{value = 6 : index}> : () -> index
  %c7 = arith.constant 7 : index
  %2 = "xls.constant_scalar"() <{value = 7 : index}> : () -> index
  %3 = "xls.constant_scalar"() <{value = 13 : index}> : () -> index
  %4 = "xls.array_update"(%arg0, %arg1, %3) : (!xls.array<14 x i32>, i32, index) -> !xls.array<14 x i32>
  return %4 : !xls.array<14 x i32>
}

// CHECK-LABEL:   func.func @tensor_extract_element(
// CHECK-SAME:                                      %[[VAL_0:.*]]: i672,
// CHECK-SAME:                                      %[[VAL_1:.*]]: i32) -> i32 attributes {xls = true} {
// CHECK:           %[[VAL_2:.*]] = "xls.constant_scalar"() <{value = 9 : index}> : () -> index
// CHECK:           %[[VAL_3:.*]] = "xls.dynamic_bit_slice"(%[[VAL_0]], %[[VAL_2]]) <{width = 32 : i64}> : (i672, index) -> i32
// CHECK:           return %[[VAL_3]] : i32
// CHECK:         }
func.func @tensor_extract_element(%arg0: !xls.array<21 x i32>, %arg1: i32) -> i32 attributes {xls = true} {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c0 = arith.constant 0 : index
  %c1_0 = arith.constant 1 : index
  %0 = "xls.constant_scalar"() <{value = 2 : index}> : () -> index
  %1 = "xls.constant_scalar"() <{value = 2 : index}> : () -> index
  %c7 = arith.constant 7 : index
  %2 = "xls.constant_scalar"() <{value = 7 : index}> : () -> index
  %3 = "xls.constant_scalar"() <{value = 9 : index}> : () -> index
  %4 = "xls.array_index"(%arg0, %3) : (!xls.array<21 x i32>, index) -> i32
  return %4 : i32
}

// CHECK-LABEL:   func.func @tensor_extract_single_slice_1d_unit(
// CHECK-SAME:                                                   %[[VAL_0:.*]]: i96,
// CHECK-SAME:                                                   %[[VAL_1:.*]]: index) -> i32 attributes {xls = true} {
// CHECK:           %[[VAL_2:.*]] = arith.constant 0 : index
// CHECK:           %[[VAL_3:.*]] = arith.constant 1 : index
// CHECK:           %[[VAL_4:.*]] = xls.umul %[[VAL_1]], %[[VAL_3]] : index
// CHECK:           %[[VAL_5:.*]] = xls.add %[[VAL_2]], %[[VAL_4]] : index
// CHECK:           %[[VAL_6:.*]] = "xls.dynamic_bit_slice"(%[[VAL_0]], %[[VAL_5]]) <{width = 32 : i64}> : (i96, index) -> i32
// CHECK:           return %[[VAL_6]] : i32
// CHECK:         }
func.func @tensor_extract_single_slice_1d_unit(%arg0: !xls.array<3 x i32>, %arg1: index) -> !xls.array<1 x i32> attributes {xls = true} {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %0 = xls.umul %arg1, %c1 : index
  %1 = xls.add %c0, %0 : index
  %2 = "xls.array_slice"(%arg0, %1) <{width = 1 : i64}> : (!xls.array<3 x i32>, index) -> !xls.array<1 x i32>
  return %2 : !xls.array<1 x i32>
}

// CHECK-LABEL:   func.func @tensor_extract_single_slice_1d_subset(
// CHECK-SAME:                                                     %[[VAL_0:.*]]: i96,
// CHECK-SAME:                                                     %[[VAL_1:.*]]: index) -> i64 attributes {xls = true} {
// CHECK:           %[[VAL_2:.*]] = arith.constant 0 : index
// CHECK:           %[[VAL_3:.*]] = arith.constant 1 : index
// CHECK:           %[[VAL_4:.*]] = xls.umul %[[VAL_1]], %[[VAL_3]] : index
// CHECK:           %[[VAL_5:.*]] = xls.add %[[VAL_2]], %[[VAL_4]] : index
// CHECK:           %[[VAL_6:.*]] = "xls.dynamic_bit_slice"(%[[VAL_0]], %[[VAL_5]]) <{width = 64 : i64}> : (i96, index) -> i64
// CHECK:           return %[[VAL_6]] : i64
// CHECK:         }
func.func @tensor_extract_single_slice_1d_subset(%arg0: !xls.array<3 x i32>, %arg1: index) -> !xls.array<2 x i32> attributes {xls = true} {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %0 = xls.umul %arg1, %c1 : index
  %1 = xls.add %c0, %0 : index
  %2 = "xls.array_slice"(%arg0, %1) <{width = 2 : i64}> : (!xls.array<3 x i32>, index) -> !xls.array<2 x i32>
  return %2 : !xls.array<2 x i32>
}

// CHECK-LABEL:   func.func @tensor_extract_single_slice_1d_all(
// CHECK-SAME:                                                  %[[VAL_0:.*]]: i96,
// CHECK-SAME:                                                  %[[VAL_1:.*]]: index) -> i96 attributes {xls = true} {
// CHECK:           %[[VAL_2:.*]] = arith.constant 0 : index
// CHECK:           %[[VAL_3:.*]] = arith.constant 1 : index
// CHECK:           %[[VAL_4:.*]] = xls.umul %[[VAL_1]], %[[VAL_3]] : index
// CHECK:           %[[VAL_5:.*]] = xls.add %[[VAL_2]], %[[VAL_4]] : index
// CHECK:           %[[VAL_6:.*]] = "xls.dynamic_bit_slice"(%[[VAL_0]], %[[VAL_5]]) <{width = 96 : i64}> : (i96, index) -> i96
// CHECK:           return %[[VAL_6]] : i96
// CHECK:         }
func.func @tensor_extract_single_slice_1d_all(%arg0: !xls.array<3 x i32>, %arg1: index) -> !xls.array<3 x i32> attributes {xls = true} {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %0 = xls.umul %arg1, %c1 : index
  %1 = xls.add %c0, %0 : index
  %2 = "xls.array_slice"(%arg0, %1) <{width = 3 : i64}> : (!xls.array<3 x i32>, index) -> !xls.array<3 x i32>
  return %2 : !xls.array<3 x i32>
}

// CHECK-LABEL:   func.func @for(
// CHECK-SAME:                   %[[VAL_0:.*]]: i64) -> i32 attributes {xls = true} {
// CHECK:           %[[VAL_1:.*]] = arith.constant 0 : i32
// CHECK:           %[[INVARIANT:.*]] = call @extern(%[[VAL_0]]) : (i64) -> i64
// CHECK:           %[[VAL_2:.*]] = xls.for inits(%[[VAL_1]]) invariants(%[[INVARIANT]]) {
// CHECK:           ^bb0(%[[VAL_3:.*]]: i32, %[[VAL_4:.*]]: i32, %[[VAL_5:.*]]: i64):
// CHECK:             %[[VAL_6:.*]] = arith.constant 1 : index
// CHECK:             %[[VAL_7:.*]] = arith.constant 0 : index
// CHECK:             %[[VAL_8:.*]] = arith.index_cast %[[VAL_3]] : i32 to index
// CHECK:             %[[VAL_9:.*]] = xls.umul %[[VAL_8]], %[[VAL_6]] : index
// CHECK:             %[[VAL_10:.*]] = xls.add %[[VAL_7]], %[[VAL_9]] : index
// CHECK:             %[[VAL_11:.*]] = "xls.dynamic_bit_slice"(%[[VAL_5]], %[[VAL_10]]) <{width = 32 : i64}> : (i64, index) -> i32
// CHECK:             %[[VAL_12:.*]] = arith.addi %[[VAL_4]], %[[VAL_11]] : i32
// CHECK:             xls.yield %[[VAL_12]] : i32
// CHECK:           } {trip_count = 1024 : i64} : (i32, i64) -> i32
// CHECK:           return %[[VAL_2]] : i32
// CHECK:         }
func.func @extern(%arg0: !xls.array<2 x i32>) -> !xls.array<2 x i32> attributes {xls = true} {
  return %arg0 : !xls.array<2 x i32>
}

func.func @for(%arg0: !xls.array<2 x i32>) -> i32 attributes {xls = true} {
  %c0 = arith.constant 0 : index
  %c1024 = arith.constant 1024 : index
  %c1 = arith.constant 1 : index
  %c0_i32 = arith.constant 0 : i32
  %inv = func.call @extern(%arg0) : (!xls.array<2 x i32>) -> !xls.array<2 x i32>
  %0 = xls.for inits(%c0_i32) invariants(%inv) {
  ^bb0(%indvar: i32, %carry: i32, %invariant: !xls.array<2 x i32>):
    %1 = arith.index_cast %indvar : i32 to index
    %c0_0 = arith.constant 0 : index
    %c1_1 = arith.constant 1 : index
    %2 = xls.umul %1, %c1_1 : index
    %3 = xls.add %c0_0, %2 : index
    %4 = "xls.array_index"(%invariant, %3) : (!xls.array<2 x i32>, index) -> i32
    %5 = arith.addi %carry, %4 : i32
    xls.yield %5 : i32
  } {trip_count = 1024 : i64} : (i32, !xls.array<2 x i32>) -> i32
  return %0 : i32
}

// CHECK-LABEL:   func.func @tensor_empty() -> i128 attributes {xls = true} {
// CHECK:           %[[VAL_0:.*]] = "xls.constant_scalar"() <{value = 0 : i128}> : () -> i128
// CHECK:           return %[[VAL_0]] : i128
// CHECK:         }
func.func @tensor_empty() -> !xls.array<4 x i32> attributes {xls = true} {
  %0 = "xls.array_zero"() : () -> !xls.array<4 x i32>
  return %0 : !xls.array<4 x i32>
}

// CHECK-LABEL: xls.chan @mychan : i24
xls.chan @mychan : !xls.array<3 x i8>

// CHECK-LABEL:   xls.eproc @eproc(
// CHECK-SAME:                     %[[VAL_0:.*]]: i32) zeroinitializer {
// CHECK:           %[[VAL_1:.*]] = "xls.constant_scalar"() <{value = 0 : i8}> : () -> i8
// CHECK:           %[[VAL_2:.*]] = "xls.constant_scalar"() <{value = 1 : i8}> : () -> i8
// CHECK:           %[[VAL_3:.*]] = "xls.constant_scalar"() <{value = 2 : i8}> : () -> i8
// CHECK:           %[[VAL_4:.*]] = xls.concat %[[VAL_3]], %[[VAL_2]], %[[VAL_1]] : (i8, i8, i8) -> i24
// CHECK:           %[[VAL_5:.*]] = xls.after_all  : !xls.token
// CHECK:           %[[VAL_6:.*]] = xls.send %[[VAL_5]], %[[VAL_4]], @mychan : i24
// CHECK:           %[[VAL_7:.*]], %[[VAL_8:.*]] = xls.blocking_receive %[[VAL_5]], @mychan : i24
// CHECK:           xls.yield %[[VAL_0]] : i32
// CHECK:         }
xls.eproc @eproc(%arg0: i32) zeroinitializer {
  %0 = "xls.constant_scalar"() <{value = 0 : i8}> : () -> i8
  %1 = "xls.constant_scalar"() <{value = 1 : i8}> : () -> i8
  %2 = "xls.constant_scalar"() <{value = 2 : i8}> : () -> i8
  %3 = xls.array %0, %1, %2 : (i8, i8, i8) -> !xls.array<3 x i8>
  %4 = xls.after_all  : !xls.token
  %5 = xls.send %4, %3, @mychan : !xls.array<3 x i8>
  %tkn_out, %result = xls.blocking_receive %4, @mychan : !xls.array<3 x i8>
  xls.yield %arg0 : i32
}

// CHECK-LABEL:   func.func @call_dslx(
// CHECK-SAME:                         %[[VAL_0:.*]]: i128) -> i128 attributes {xls = true} {
// CHECK:           %[[VAL_1:.*]] = xls.bit_slice %[[VAL_0]] {start = 0 : i64, width = 32 : i64} : (i128) -> i32
// CHECK:           %[[VAL_2:.*]] = xls.call_dslx "foo.x" : "f"(%[[VAL_1]]) : (i32) -> f32
// CHECK:           %[[VAL_3:.*]] = xls.bit_slice %[[VAL_0]] {start = 1 : i64, width = 32 : i64} : (i128) -> i32
// CHECK:           %[[VAL_4:.*]] = xls.call_dslx "foo.x" : "f"(%[[VAL_3]]) : (i32) -> f32
// CHECK:           %[[VAL_5:.*]] = xls.bit_slice %[[VAL_0]] {start = 2 : i64, width = 32 : i64} : (i128) -> i32
// CHECK:           %[[VAL_6:.*]] = xls.call_dslx "foo.x" : "f"(%[[VAL_5]]) : (i32) -> f32
// CHECK:           %[[VAL_7:.*]] = xls.bit_slice %[[VAL_0]] {start = 3 : i64, width = 32 : i64} : (i128) -> i32
// CHECK:           %[[VAL_8:.*]] = xls.call_dslx "foo.x" : "f"(%[[VAL_7]]) : (i32) -> f32
// CHECK:           %[[VAL_9:.*]] = arith.bitcast %[[VAL_2]] : f32 to i32
// CHECK:           %[[VAL_10:.*]] = arith.bitcast %[[VAL_4]] : f32 to i32
// CHECK:           %[[VAL_11:.*]] = arith.bitcast %[[VAL_6]] : f32 to i32
// CHECK:           %[[VAL_12:.*]] = arith.bitcast %[[VAL_8]] : f32 to i32
// CHECK:           %[[VAL_13:.*]] = xls.concat %[[VAL_12]], %[[VAL_11]], %[[VAL_10]], %[[VAL_9]] : (i32, i32, i32, i32) -> i128
// CHECK:           return %[[VAL_13]] : i128
// CHECK:         }
func.func @call_dslx(%arg0: !xls.array<4 x i32>) -> !xls.array<4 x f32> attributes {xls = true} {
  %0 = "xls.array_index_static"(%arg0) <{index = 0 : i64}> : (!xls.array<4 x i32>) -> i32
  %1 = xls.call_dslx "foo.x" : "f"(%0) : (i32) -> f32
  %2 = "xls.array_index_static"(%arg0) <{index = 1 : i64}> : (!xls.array<4 x i32>) -> i32
  %3 = xls.call_dslx "foo.x" : "f"(%2) : (i32) -> f32
  %4 = "xls.array_index_static"(%arg0) <{index = 2 : i64}> : (!xls.array<4 x i32>) -> i32
  %5 = xls.call_dslx "foo.x" : "f"(%4) : (i32) -> f32
  %6 = "xls.array_index_static"(%arg0) <{index = 3 : i64}> : (!xls.array<4 x i32>) -> i32
  %7 = xls.call_dslx "foo.x" : "f"(%6) : (i32) -> f32
  %8 = xls.array %1, %3, %5, %7 : (f32, f32, f32, f32) -> !xls.array<4 x f32>
  return %8 : !xls.array<4 x f32>
}

// CHECK-LABEL:   func.func @array_concat(
// CHECK-SAME:                     %[[VAL_0:.*]]: i64,
// CHECK-SAME:                     %[[VAL_1:.*]]: i64) -> i128 attributes {xls = true} {
// CHECK:           %[[VAL_2:.*]] = xls.concat %[[VAL_0]], %[[VAL_1]] : (i64, i64) -> i128
// CHECK:           return %[[VAL_2]] : i128
// CHECK:         }
func.func @array_concat(%arg0: !xls.array<2 x i32>, %arg1: !xls.array<2 x i32>) -> !xls.array<4 x i32> attributes {xls = true} {
  %0 = "xls.array_concat"(%arg0, %arg1) : (!xls.array<2 x i32>, !xls.array<2 x i32>) -> !xls.array<4 x i32>
  return %0 : !xls.array<4 x i32>
}

// CHECK-LABEL:   func.func @array_update_slice(
// CHECK-SAME:                         %[[VAL_0:.*]]: i128,
// CHECK-SAME:                         %[[VAL_1:.*]]: i64,
// CHECK-SAME:                         %[[VAL_2:.*]]: i32) -> i128 attributes {xls = true} {
// CHECK:           %[[VAL_3:.*]] = "xls.bit_slice_update"(%[[VAL_0]], %[[VAL_2]], %[[VAL_1]]) : (i128, i32, i64) -> i128
func.func @array_update_slice(%arg0: !xls.array<4 x i32>, %arg1: !xls.array<2 x i32>, %arg2: i32) -> !xls.array<4 x i32> attributes {xls = true} {
  %0 = xls.array_update_slice %arg1 into %arg0[%arg2 +: 2] : !xls.array<4 x i32>
  return %0 : !xls.array<4 x i32>
}
