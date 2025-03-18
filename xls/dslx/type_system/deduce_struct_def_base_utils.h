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

#ifndef XLS_DSLX_TYPE_SYSTEM_DEDUCE_STRUCT_DEF_BASE_UTILS_H_
#define XLS_DSLX_TYPE_SYSTEM_DEDUCE_STRUCT_DEF_BASE_UTILS_H_

#include <memory>
#include <vector>

#include "absl/functional/any_invocable.h"
#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "xls/dslx/frontend/ast.h"
#include "xls/dslx/frontend/pos.h"
#include "xls/dslx/type_system/deduce_ctx.h"
#include "xls/dslx/type_system/type.h"

namespace xls::dslx {

// Type checks the skeleton of a `StructDefBase`, according to rules common to
// all subclasses.
absl::Status TypecheckStructDefBase(const StructDefBase* struct_def,
                                    DeduceCtx* ctx);

// Deduces and type checks the types of all members of a `StructDefBase`. The
// `validator` is used to decide if each member is acceptable in the context,
// given the source code span and type of the member. If the `validator` errors,
// then this function stops processing members and returns that error.
absl::StatusOr<std::vector<std::unique_ptr<Type>>> DeduceStructDefBaseMembers(
    const StructDefBase* struct_def, DeduceCtx* ctx,
    absl::AnyInvocable<absl::Status(DeduceCtx* ctx, const Span&, const Type&)>
        validator);

// A validator to be used with `DeduceStructDefBaseMembers` for the members of a
// struct.
absl::Status ValidateStructMember(DeduceCtx* ctx, const Span& span,
                                  const Type& type);

// A validator to be used with `DeduceStructDefBaseMembers` for the members of a
// proc.
absl::Status ValidateProcMember(DeduceCtx* ctx, const Span& span,
                                const Type& type);

}  // namespace xls::dslx

#endif  // XLS_DSLX_TYPE_SYSTEM_DEDUCE_STRUCT_DEF_BASE_UTILS_H_
