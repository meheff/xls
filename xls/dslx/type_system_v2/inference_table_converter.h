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

#ifndef XLS_DSLX_TYPE_SYSTEM_V2_INFERENCE_TABLE_CONVERTER_H_
#define XLS_DSLX_TYPE_SYSTEM_V2_INFERENCE_TABLE_CONVERTER_H_

#include <optional>

#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "xls/dslx/frontend/ast.h"
#include "xls/dslx/type_system/type_info.h"
#include "xls/dslx/type_system_v2/inference_table.h"

namespace xls::dslx {

// The result of resolving the target of a function call. If the `target_object`
// is specified, then it is an instance method being invoked on `target_object`.
// Otherwise, it is a static function which may or may not be a member.
struct FunctionAndTargetObject {
  const Function* function = nullptr;
  const std::optional<Expr*> target_object;
  std::optional<const ParametricContext*> target_struct_context;
  // This is part of a temporary hack to allow type checking of certain
  // builtins. Built-ins in the builtin_stubs.x file will NOT have this
  // value set to true.
  bool is_special_builtin = false;
};

// Class that facilitates the conversion of an `InferenceTable` to
// `TypeInfo`.
class InferenceTableConverter {
 public:
  virtual ~InferenceTableConverter() = default;

  // Converts all type info for the subtree rooted at `node`. `function` is
  // the containing function of the subtree, if any. `parametric_context` is
  // the invocation in whose context the types should be evaluated, if any.
  //
  // When `node` is an actual function argument that is being converted in order
  // to determine a parametric in its own formal type, special behavior is
  // needed, which is enabled by the `filter_param_type_annotations` flag. In
  // such a case, the argument may have one annotation that is
  // `ParamType(function_type, n)`, and since that is the very thing we are
  // really trying to infer, we can't factor it in to the type of the argument
  // value. In all other cases, the flag should be false.
  virtual absl::Status ConvertSubtree(
      const AstNode* node, std::optional<const Function*> function,
      std::optional<const ParametricContext*> parametric_context,
      bool filter_param_type_annotations = false) = 0;

  // Determines what function is being invoked by a `callee` expression.
  virtual absl::StatusOr<const FunctionAndTargetObject> ResolveFunction(
      const Expr* callee, std::optional<const Function*> caller_function,
      std::optional<const ParametricContext*> caller_context) = 0;

  // Returns true if the given function is a builtin.
  virtual bool IsBuiltin(const Function* node) = 0;

  // Returns the resulting base type info for the entire conversion.
  virtual TypeInfo* GetBaseTypeInfo() = 0;
};

}  // namespace xls::dslx

#endif  // XLS_DSLX_TYPE_SYSTEM_V2_INFERENCE_TABLE_CONVERTER_H_
