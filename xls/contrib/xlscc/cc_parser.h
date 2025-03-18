// Copyright 2021 The XLS Authors
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

#ifndef XLS_CONTRIB_XLSCC_PARSE_CPP_H_
#define XLS_CONTRIB_XLSCC_PARSE_CPP_H_

#include <memory>
#include <optional>
#include <string>
#include <string_view>

#include "absl/container/flat_hash_map.h"
#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "absl/synchronization/blocking_counter.h"
#include "absl/types/span.h"
#include "clang/include/clang/AST/Decl.h"
#include "clang/include/clang/AST/DeclBase.h"
#include "clang/include/clang/AST/Expr.h"
#include "clang/include/clang/Basic/SourceLocation.h"
#include "xls/common/thread.h"
#include "xls/contrib/xlscc/metadata_output.pb.h"
#include "xls/ir/package.h"
#include "xls/ir/source_location.h"

namespace xlscc {

class CCParser;
class LibToolVisitor;
class DiagnosticInterceptor;
class LibToolFrontendAction;
class LibToolPPCallback;

// Needs to be here because std::unique uses sizeof()
class LibToolThread {
 public:
  LibToolThread(std::string_view source_filename,
                std::string_view top_class_name,
                absl::Span<std::string_view> command_line_args,
                CCParser& parser);

  void Start();
  void Join();

 private:
  void Run();

  std::optional<xls::Thread> thread_;
  std::string_view source_filename_;
  std::string_view top_class_name_;
  absl::Span<std::string_view> command_line_args_;
  CCParser& parser_;
};

// Parses and then holds ownership of a C++ AST
class CCParser {
  friend class LibToolVisitor;
  friend class DiagnosticInterceptor;
  friend class LibToolFrontendAction;
  friend class LibToolPPCallback;
  friend class HlsDesignPragmaHandler;
  friend class HlsPipelineInitIntervalPragmaHandler;
  friend class HlsUnrollPragmaHandler;
  friend class HlsChannelStrictnessPragmaHandler;
  friend class HlsNoParamPragmaHandler;

 public:
  // Deletes the AST
  ~CCParser();

  // Selects a top, or entry, function by name
  // If top_class_name is specified, then an instantiation is injected.
  // Either this must be called before ScanFile, or a #pragma hls_top
  // must be present in the file(s) being scanned, in order for
  // GetTopFunction() to return a valid pointer
  absl::Status SelectTop(std::string_view top_function_name,
                         std::string_view top_class_name = "");

  // This function uses Clang to parse a source file and then walks its
  //  AST to discover global constructs. It will also scan the file
  //  and includes, recursively, for #pragma statements.
  //
  // Among these are functions, which can be used as entry points
  //  for translation to IR.
  //
  // source_filename must be .cc
  // Retains references to the TU until ~Translator()
  // This function may only be called once in the lifetime of a CCParser.
  absl::Status ScanFile(std::string_view source_filename,
                        absl::Span<std::string_view> command_line_args);

  // Call after ScanFile, as the top function may be specified by #pragma
  // If none was found, an error is returned
  absl::StatusOr<std::string> GetEntryFunctionName() const;

  // Returns a pointer into the AST for the top, or entry, function
  // Returns nullptr if no top function has been found
  absl::StatusOr<const clang::FunctionDecl*> GetTopFunction() const;

  // Finds the VarDecl for the special xls_builtin.h variable
  // or an error if not found
  absl::StatusOr<const clang::VarDecl*> GetXlsccOnReset() const;

  void AddSourceInfoToMetadata(xlscc_metadata::MetadataOutput& output);
  void AddSourceInfoToPackage(xls::Package& package);

  xls::SourceInfo GetLoc(const clang::Stmt& stmt);
  clang::PresumedLoc GetPresumedLoc(const clang::Stmt& stmt);
  xls::SourceInfo GetLoc(const clang::Decl& decl);
  clang::PresumedLoc GetPresumedLoc(const clang::Decl& decl);
  xls::SourceInfo GetLoc(const clang::Expr& expr);
  xls::SourceInfo GetLoc(const clang::PresumedLoc& loc);
  std::string LocString(const xls::SourceInfo& loc);

  clang::SourceManager* sm_ = nullptr;

 private:
  bool LibToolVisitFunction(clang::FunctionDecl* func);
  bool LibToolVisitVarDecl(clang::VarDecl* func);
  absl::Status libtool_visit_status_ = absl::OkStatus();

  std::unique_ptr<LibToolThread> libtool_thread_;
  std::unique_ptr<absl::BlockingCounter> libtool_wait_for_parse_;
  std::unique_ptr<absl::BlockingCounter> libtool_wait_for_destruct_;

  // Scans for top-level function candidates
  absl::Status VisitFunction(const clang::FunctionDecl* funcdecl);
  absl::Status VisitVarDecl(const clang::VarDecl* funcdecl);

  absl::flat_hash_map<const clang::Stmt*, const clang::CallExpr*>
      intrinsic_calls_by_stmt_;

  const clang::FunctionDecl* top_function_ = nullptr;
  std::string_view top_function_name_ = "";
  std::string_view top_class_name_ = "";
  const clang::VarDecl* xlscc_on_reset_ = nullptr;

  // For source location
  absl::flat_hash_map<std::string, int> file_numbers_;
  int next_file_number_ = 1;
};

}  // namespace xlscc

#endif  // XLS_CONTRIB_XLSCC_PARSE_CPP_H_
