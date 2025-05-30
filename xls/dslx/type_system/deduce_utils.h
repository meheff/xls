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

#ifndef XLS_DSLX_TYPE_SYSTEM_DEDUCE_UTILS_H_
#define XLS_DSLX_TYPE_SYSTEM_DEDUCE_UTILS_H_

#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <variant>
#include <vector>

#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "absl/strings/str_format.h"
#include "absl/types/span.h"
#include "xls/common/status/ret_check.h"
#include "xls/dslx/errors.h"
#include "xls/dslx/frontend/ast.h"
#include "xls/dslx/frontend/module.h"
#include "xls/dslx/frontend/pos.h"
#include "xls/dslx/import_data.h"
#include "xls/dslx/interp_value.h"
#include "xls/dslx/type_system/deduce_ctx.h"
#include "xls/dslx/type_system/parametric_with_type.h"
#include "xls/dslx/type_system/type.h"
#include "xls/dslx/type_system/type_info.h"
#include "xls/dslx/warning_collector.h"

namespace xls::dslx {
using ColonRefSubjectT =
    std::variant<Module*, EnumDef*, BuiltinNameDef*, ArrayTypeAnnotation*,
                 StructDef*, TypeRefTypeAnnotation*, ColonRef*>;

// Validates that "number" fits in `bits_like` if the size is known. `bits_like`
// should have been derived from `type` -- this routine uses `type` for error
// reporting.
absl::Status TryEnsureFitsInType(const Number& number,
                                 const BitsLikeProperties& bits_like,
                                 const Type& type);

// Validates whether the given `type` is bits-like and, if so, delegates to
// `TryEnsureFitsInType(number, bits_like, type)`.
absl::Status TryEnsureFitsInType(const Number& number, const Type& type);

// Shorthand for the above where we know a prori the type is a `BitsType` (note
// that there are types that are bits-like that are not exactly `BitsType`, see
// `IsBitsLike`).
absl::Status TryEnsureFitsInBitsType(const Number& number,
                                     const BitsType& type);

// Validates whether the purported array being indexed by an `Index` operation
// is really a container that's allowed to be indexed like an array. Note that
// the hard assumption that it must be an actual `ArrayType` is only in the v1
// consumer of this function, which uses the `ArrayType` to produce the element
// type.
absl::Status ValidateArrayTypeForIndex(const Index& node, const Type& type,
                                       const FileTable& file_table);

// Validates whether the purported tuple being indexed by a `TupleIndex`
// operation is really a tuple.
absl::Status ValidateTupleTypeForIndex(const TupleIndex& node, const Type& type,
                                       const FileTable& file_table);

// Validates the index expression for an array index operation that is actually
// an index and not a slice.
absl::Status ValidateArrayIndex(const Index& node, const Type& array_type,
                                const Type& index_type, const TypeInfo& ti,
                                const FileTable& file_table);

// Validates the index expression for a tuple index operation.
absl::Status ValidateTupleIndex(const TupleIndex& node, const Type& tuple_type,
                                const Type& index_type, const TypeInfo& ti,
                                const FileTable& file_table);

// Record that the current function being checked has a side effect and will
// require an implicit token when converted to IR.
void UseImplicitToken(DeduceCtx* ctx);

// Returns whether "e" is a NameRef referring to the given "name_def".
bool IsNameRefTo(const Expr* e, const NameDef* name_def);

// Checks that "number" can legitmately conform to type "type".
absl::Status ValidateNumber(const Number& number, const Type& type);

// Checks that the given argument being formatted by a macro like `trace_fmt!`
// or `vtrace_fmt!` is actually possible to format as a string.
absl::Status ValidateFormatMacroArgument(const Type& type, const Span& span,
                                         const FileTable& file_table);

// Returns the basis of the given ColonRef.
//
// In valid cases this will generally be:
// * a module
// * an enum definition
// * a builtin type (with a constant item on it, a la `u7::MAX`)
// * a `StructDef` with an `impl`.
absl::StatusOr<ColonRefSubjectT> ResolveColonRefSubjectForTypeChecking(
    ImportData* import_data, const TypeInfo* type_info,
    const ColonRef* colon_ref);

// Implementation of the above that can be called after type checking has been
// performed, in which case we can eliminate some of the (invalid) possibilities
// so they no longer need to be handled.
absl::StatusOr<std::variant<Module*, EnumDef*, BuiltinNameDef*,
                            ArrayTypeAnnotation*, Impl*>>
ResolveColonRefSubjectAfterTypeChecking(ImportData* import_data,
                                        const TypeInfo* type_info,
                                        const ColonRef* colon_ref);

// Finds the Function identified by the given node (either NameRef or ColonRef),
// using the associated ImportData for import Module lookup.
// The target function must have been typechecked prior to this call.
absl::StatusOr<Function*> ResolveFunction(Expr* callee,
                                          const TypeInfo* type_info);

// Finds the Proc identified by the given node (either NameRef or ColonRef),
// using the associated ImportData for import Module lookup.
// The target proc must have been typechecked prior to this call.
absl::StatusOr<Proc*> ResolveProc(Expr* callee, const TypeInfo* type_info);

// Normalizes the given optional start and width values for a slice of a bit
// vector of size `bit_count`. One or both values may be omitted (to indicate
// the absolute start or end), negative (i.e. an end-based index), or out of
// range. This function will produce positive, in-range values.
absl::StatusOr<StartAndWidth> ResolveBitSliceIndices(
    int64_t bit_count, std::optional<int64_t> start_opt,
    std::optional<int64_t> limit_opt);

// Returns an AST node typed T from module "m", resolved via name "name".
//
// Errors are attributed to span "span".
//
// Prefer this function to Module::GetMemberOrError(), as this gives a
// positional type-inference-error as its status result when the requested
// resolution cannot be performed.
template <typename T>
inline absl::StatusOr<T*> GetMemberOrTypeInferenceError(Module* m,
                                                        std::string_view name,
                                                        const Span& span) {
  std::optional<ModuleMember*> member = m->FindMemberWithName(name);
  if (!member.has_value()) {
    return TypeInferenceErrorStatus(
        span, nullptr,
        absl::StrFormat("Name '%s' does not exist in module `%s`", name,
                        m->name()),
        *m->file_table());
  }

  if (!std::holds_alternative<T*>(*member.value())) {
    const FileTable& file_table = *m->owner()->file_table();
    return TypeInferenceErrorStatus(
        span, nullptr,
        absl::StrFormat(
            "Name '%s' in module `%s` refers to a %s but a %s is required",
            name, m->name(), GetModuleMemberTypeName(*member.value()),
            T::GetDebugTypeName()),
        file_table);
  }

  T* result = std::get<T*>(*member.value());
  XLS_RET_CHECK(result != nullptr);
  return result;
}

// Deduces the type for a ParametricBinding (via its type annotation).
absl::StatusOr<std::unique_ptr<Type>> ParametricBindingToType(
    const ParametricBinding& binding, DeduceCtx* ctx);

// Decorates parametric binding AST nodes with their deduced types.
//
// This is used externally in things like parametric instantiation of DSLX
// builtins like the higher order function "map".
absl::StatusOr<std::vector<ParametricWithType>> ParametricBindingsToTyped(
    absl::Span<ParametricBinding* const> bindings, DeduceCtx* ctx);

// Dereferences the "original" struct reference to a struct definition or
// returns an error.
//
// Args:
//  span: The span of the original construct trying to dereference the struct
//    (e.g. a StructInstance).
//  original: The original struct reference value (used in error reporting).
//  current: The current type definition being dereferenced towards a struct
//    definition (note there can be multiple levels of typedefs and such).
//  type_info: The type information that the "current" TypeDefinition resolves
//    against.
absl::StatusOr<StructDef*> DerefToStruct(const Span& span,
                                         std::string_view original_ref_text,
                                         TypeDefinition current,
                                         const TypeInfo* type_info);

// Wrapper around the DerefToStruct above (that works on TypeDefinitions) that
// takes a `TypeAnnotation` instead.
absl::StatusOr<StructDef*> DerefToStruct(const Span& span,
                                         std::string_view original_ref_text,
                                         const TypeAnnotation& type_annotation,
                                         const TypeInfo* type_info);

// Checks that the number of tuple elements in the name def tree matches the
// number of tuple elements in the type; if a "rest of tuple" leaf is
// present, only one is allowed, and it is not counted in the number of names.
//
// Returns the number of tuple elements (first) and the number of names that
// will be bound in the given NameDefTree (second).
//
// The latter may be less than the former if there is a "rest of tuple" leaf.
using TupleTypeOrAnnotation =
    std::variant<const TupleType*, const TupleTypeAnnotation*>;
absl::StatusOr<std::pair<int64_t, int64_t>> GetTupleSizes(
    const NameDefTree* name_def_tree, TupleTypeOrAnnotation tuple_type);

// Typechecks the name def tree items against type, and recursively processes
// the node/type pairs according to the `process_tuple_member` function.
// If `constexpr_value` is provided for the tuple, the appropriate
// subvalue will also be passed into `process_tuple_member`.
//
// For example:
//
//    (a, (b, c))  vs (u8, (u4, u2))
//
// Will call `process_tuple_member` with the following arguments:
//
//    (a, u8, ...)
//    (b, u4, ...)
//    (c, u2, ...)
//
using TypeOrAnnotation = std::variant<const Type*, const TypeAnnotation*>;
absl::Status MatchTupleNodeToType(
    std::function<absl::Status(AstNode*, TypeOrAnnotation,
                               std::optional<InterpValue>)>
        process_tuple_member,
    const NameDefTree* name_def_tree, TypeOrAnnotation type,
    const FileTable& file_table, std::optional<InterpValue> constexpr_value);

// Converts a `BuiltinTypeAnnotation` to an appropriate `Type` that is not
// wrapped in a `MetaType`.
absl::StatusOr<std::unique_ptr<Type>> ConcretizeBuiltinTypeAnnotation(
    const BuiltinTypeAnnotation& annotation, const FileTable& file_table);

// If the attribute references an impl function, return that function.
absl::StatusOr<std::optional<Function*>> ImplFnFromCallee(
    const Attr* attr, const TypeInfo* type_info);

// Determines the real type for `Self` in an impl method, i.e. the type of
// the owning struct. This is lexically determined by AST traversal, with any
// parametrics left unknown.
absl::StatusOr<const TypeAnnotation*> GetRealTypeAnnotationForSelf(
    const SelfTypeAnnotation* self, const FileTable& file_table);

// Returns true if the cast-conversion from "from" to "to" is acceptable (i.e.
// should not cause a type error to occur).
bool IsAcceptableCast(const Type& from, const Type& to);

// Notes the constexpr value for a builtin function invocation in `ti` if
// applicable.
absl::Status NoteBuiltinInvocationConstExpr(std::string_view fn_name,
                                            const Invocation* invocation,
                                            const FunctionType& fn_type,
                                            TypeInfo* ti);

// Returns the TypeInfo for the given node, preferring the current TypeInfo if
// the node is in the same module, otherwise giving the root TypeInfo for
// the node's module.
const TypeInfo& GetTypeInfoForNodeIfDifferentModule(
    AstNode* node, const TypeInfo& current_type_info,
    const ImportData& import_data);

// It's common to accidentally use different constant naming conventions
// coming from other environments -- warn folks if it's not following
// https://doc.rust-lang.org/1.0.0/style/style/naming/README.html
void WarnOnInappropriateConstantName(std::string_view identifier,
                                     const Span& span, const Module& module,
                                     WarningCollector* warning_collector);

// Gets the total bit count of the given `type` as a u32 `InterpValue`.
absl::StatusOr<InterpValue> GetBitCountAsInterpValue(const Type* type);

// Gets the element count of the given `type` as a u32 `InterpValue`. The
// element count depends on the kind of type:
//
//  kind          element count
//  -----------------------------
//  bits-like     total bit count
//  array         number of elements indexable by first index
//  tuple         number of top-level members
//  struct        number of top-level members
absl::StatusOr<InterpValue> GetElementCountAsInterpValue(const Type* type);

// Returns the patterns of the arm as a string.
std::string PatternsToString(const MatchArm* arm);
}  // namespace xls::dslx

#endif  // XLS_DSLX_TYPE_SYSTEM_DEDUCE_UTILS_H_
