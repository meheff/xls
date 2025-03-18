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

#ifndef XLS_DSLX_TRANSLATORS_DSLX_TO_VERILOG_H_
#define XLS_DSLX_TRANSLATORS_DSLX_TO_VERILOG_H_

#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "absl/container/flat_hash_map.h"
#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "xls/codegen/vast/vast.h"
#include "xls/dslx/frontend/ast.h"
#include "xls/dslx/import_data.h"
#include "xls/dslx/type_system/type.h"
#include "xls/dslx/type_system/type_info.h"
#include "xls/ir/name_uniquer.h"

namespace xls::dslx {

// Responsible for managing the conversion of DSLX types to compatible
// Verilog types within a Verilog package.
class DslxTypeToVerilogManager {
 public:
  // Creates an instance of this manager.
  //
  // package_name will be the name of the Verilog package created via Emit().
  inline static absl::StatusOr<DslxTypeToVerilogManager> Create(
      std::string_view package_name,
      verilog::FileType verilog_type = verilog::FileType::kSystemVerilog) {
    if (verilog_type != verilog::FileType::kSystemVerilog) {
      return absl::UnimplementedError(
          "Verilog file type should be SystemVerilog for DslxTypeToVerilog "
          "conversion");
    }

    return DslxTypeToVerilogManager(package_name);
  }

  // Adds a typedef for the type associated with function func's parameter
  // param_name to the VerilogFile.
  //
  // The type will be named
  //  A. verilog_type_name if given
  //  B. else
  //    1. <function_name>_<parameter_name>_t for anonymous types.
  //    2. <dslx_type_name> for DSLX type references.
  //
  // Note: func should already be type-checked and type information should be
  // contained in import_data.
  absl::Status AddTypeForFunctionParam(
      dslx::Function* func, dslx::ImportData* import_data,
      std::string_view param_name,
      std::optional<std::string_view> verilog_type_name = std::nullopt);

  // Adds a typedef for the type associated with function func's output to
  // the VerilogFile.
  //
  // The type will be named
  //  A. verilog_type_name if given
  //  B. else
  //    1. <function_name>_out_t for anonymous types.
  //    2. <dslx_type_name> for DSLX type references.
  //
  // Note: func should already be type-checked and type information should
  // be contained in import_data.
  absl::Status AddTypeForFunctionOutput(
      dslx::Function* func, dslx::ImportData* import_data,
      std::optional<std::string_view> verilog_type_name = std::nullopt);

  // Adds a typedef for a type definition to the VerilogFile.
  //
  // The type will be named
  //  A. verilog_type_name if given
  //  B. else
  //    1. <function_name>_out_t for anonymous types.
  //    2. <dslx_type_name> for DSLX type references.
  //
  // Note: def should already be type-checked and type information should be
  // contained in import_data.
  absl::Status AddTypeForTypeDefinition(
      const dslx::TypeDefinition& def, dslx::ImportData* import_data,
      std::optional<std::string_view> verilog_type_name = std::nullopt);

  // Emits added DSLX types as a verilog package.
  std::string Emit() const { return file_->Emit(); }

 private:
  explicit DslxTypeToVerilogManager(std::string_view package_name);

  // Adds a typedef for the type associated with type_annotation to the
  // VerilogFile.
  //
  // Note: type_annotation should already be type-checked and type information
  // should be contained in import_data.
  absl::Status AddTypeToVerilogPackage(Type* type,
                                       TypeAnnotation* type_annotation,
                                       TypeInfo* type_info,
                                       ImportData* import_data,
                                       std::string_view typedef_identifier);

  // Adds a typedef for the type associated with type_definition to the
  // VerilogFile.
  //
  // Note: type_definition should already be type-checked and type information
  // should be contained in import_data.
  absl::Status AddTypeToVerilogPackage(Type* type,
                                       const TypeDefinition& type_definition,
                                       ImportData* import_data,
                                       std::string_view typedef_identifier);

  // Get Array Bounds and base type.
  //
  // Ordering of the vector is outer-most bound to inner-most. For
  // example, given array type 'bits[32][4][5]' yields {5, 4} as dims and
  // bits[32] as the base type.
  absl::StatusOr<std::pair<std::vector<int64_t>, verilog::DataType*>>
  GetArrayDimsAndBaseType(const Type* type,
                          const ArrayTypeAnnotation* array_type_annotation,
                          ImportData* import_data);

  // Converts a TypeAnnotation to a VAST Verilog type.
  absl::StatusOr<verilog::DataType*> TypeAnnotationToVastType(
      const Type* type, const TypeAnnotation* type_annotation,
      ImportData* import_data);
  // Converts a TypeDefinition to a VAST Verilog type.
  absl::StatusOr<verilog::DataType*> TypeDefinitionToVastType(
      const TypeDefinition& type_definition, ImportData* import_data,
      std::optional<std::string_view> identifier = std::nullopt);

  // Vast package that contains typedefs for DSLX types.
  verilog::VerilogPackage* top_pkg_;

  // Vast file containing a single package.
  std::unique_ptr<verilog::VerilogFile> file_;

  // Set of already-visited named types. Keys are the nominal type name.
  // Note that this is not the same as the typedef identifier which can have a
  // user-provided override.
  absl::flat_hash_map<AstNode*, verilog::DataType*> converted_types_;

  std::unique_ptr<NameUniquer> typedef_name_uniquer_;
};

}  // namespace xls::dslx

#endif  // XLS_DSLX_TRANSLATORS_DSLX_TO_VERILOG_H_
