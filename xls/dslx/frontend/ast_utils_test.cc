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
#include "xls/dslx/frontend/ast_utils.h"

#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <variant>
#include <vector>

#include "gtest/gtest.h"
#include "absl/log/log.h"
#include "xls/common/casts.h"
#include "xls/common/status/matchers.h"
#include "xls/dslx/frontend/ast.h"
#include "xls/dslx/frontend/module.h"
#include "xls/dslx/frontend/parser.h"
#include "xls/dslx/frontend/pos.h"
#include "xls/dslx/frontend/scanner.h"
#include "xls/dslx/parse_and_typecheck.h"

namespace xls::dslx {
namespace {

TEST(ProcConfigIrConverterTest, BitVectorTests) {
  constexpr std::string_view kDslxText = R"(type MyType = u37;
type MyTuple = (u23, u1);
type MyArray = bits[22][33];
enum MyEnum : u7 { kA = 0, }
type MyEnumAlias = MyEnum;
struct MyStruct { x: u17 }

// A single struct which has many members of different types. This is an easy
// way of gathering together many TypeAnnotations and referring to them.
struct TheStruct {
  a: u32,
  b: s12,
  c: uN[111],
  d: sN[32],
  e: bits[312],
  f: bool,
  g: MyType,
  h: MyEnum,
  i: MyEnumAlias,
  j: (u23, u1),
  k: bits[22][33],
  l: MyStruct,
  m: MyTuple,
  n: MyArray,
  x: xN[bool:0x0][44],
  y: xN[bool:0x1][44],
}
 )";
  FileTable file_table;
  XLS_ASSERT_OK_AND_ASSIGN(auto module, ParseModule(kDslxText, "fake_path.x",
                                                    "the_module", file_table));

  XLS_ASSERT_OK_AND_ASSIGN(std::vector<AstNode*> nodes,
                           CollectUnder(module.get(), /*want_types=*/true));
  StructDef* the_struct_def = nullptr;
  for (AstNode* node : nodes) {
    if (auto* struct_def = dynamic_cast<StructDef*>(node);
        struct_def != nullptr && struct_def->identifier() == "TheStruct") {
      the_struct_def = struct_def;
      break;
    }
  }
  ASSERT_NE(the_struct_def, nullptr);

  // Helper that extracts the metadata associated with a given field name.
  auto get_type_metadata =
      [&](std::string_view name) -> std::optional<BitVectorMetadata> {
    for (const StructMemberNode* member : the_struct_def->members()) {
      if (member->name() == name) {
        return ExtractBitVectorMetadata(member->type());
      }
    }
    LOG(FATAL) << "Unknown field: " << name;
  };

  EXPECT_EQ(std::get<int64_t>(get_type_metadata("a")->bit_count), 32);
  EXPECT_FALSE(get_type_metadata("a")->is_signed);
  EXPECT_EQ(get_type_metadata("a")->kind, BitVectorKind::kBitType);

  EXPECT_EQ(std::get<int64_t>(get_type_metadata("b")->bit_count), 12);
  EXPECT_TRUE(get_type_metadata("b")->is_signed);
  EXPECT_EQ(get_type_metadata("b")->kind, BitVectorKind::kBitType);

  EXPECT_EQ(std::get<Expr*>(get_type_metadata("c")->bit_count)->ToString(),
            "111");
  EXPECT_FALSE(get_type_metadata("c")->is_signed);
  EXPECT_EQ(get_type_metadata("c")->kind, BitVectorKind::kBitType);

  EXPECT_EQ(std::get<Expr*>(get_type_metadata("d")->bit_count)->ToString(),
            "32");
  EXPECT_TRUE(get_type_metadata("d")->is_signed);
  EXPECT_EQ(get_type_metadata("d")->kind, BitVectorKind::kBitType);

  EXPECT_EQ(std::get<Expr*>(get_type_metadata("e")->bit_count)->ToString(),
            "312");
  EXPECT_FALSE(get_type_metadata("e")->is_signed);
  EXPECT_EQ(get_type_metadata("e")->kind, BitVectorKind::kBitType);

  EXPECT_EQ(std::get<int64_t>(get_type_metadata("f")->bit_count), 1);
  EXPECT_FALSE(get_type_metadata("f")->is_signed);
  EXPECT_EQ(get_type_metadata("f")->kind, BitVectorKind::kBitType);

  EXPECT_EQ(std::get<int64_t>(get_type_metadata("g")->bit_count), 37);
  EXPECT_FALSE(get_type_metadata("g")->is_signed);
  EXPECT_EQ(get_type_metadata("g")->kind, BitVectorKind::kBitTypeAlias);

  EXPECT_EQ(std::get<int64_t>(get_type_metadata("h")->bit_count), 7);
  EXPECT_FALSE(get_type_metadata("h")->is_signed);
  EXPECT_EQ(get_type_metadata("h")->kind, BitVectorKind::kEnumType);

  EXPECT_EQ(std::get<int64_t>(get_type_metadata("i")->bit_count), 7);
  EXPECT_FALSE(get_type_metadata("i")->is_signed);
  EXPECT_EQ(get_type_metadata("i")->kind, BitVectorKind::kEnumTypeAlias);

  // Note: for an `xN` we expect the bit count to be an expression.
  ASSERT_TRUE(get_type_metadata("x").has_value());
  ASSERT_TRUE(std::holds_alternative<Expr*>(get_type_metadata("x")->bit_count));
  EXPECT_EQ(std::get<Expr*>(get_type_metadata("x")->bit_count)->ToString(),
            "44");
  EXPECT_FALSE(get_type_metadata("x")->is_signed);
  EXPECT_EQ(get_type_metadata("x")->kind, BitVectorKind::kBitType);

  // Note: for an `xN` we expect the bit count to be an expression.
  ASSERT_TRUE(get_type_metadata("y").has_value());
  ASSERT_TRUE(std::holds_alternative<Expr*>(get_type_metadata("y")->bit_count));
  EXPECT_EQ(std::get<Expr*>(get_type_metadata("y")->bit_count)->ToString(),
            "44");
  EXPECT_TRUE(get_type_metadata("y")->is_signed);
  EXPECT_EQ(get_type_metadata("y")->kind, BitVectorKind::kBitType);

  EXPECT_FALSE(get_type_metadata("j").has_value());
  EXPECT_FALSE(get_type_metadata("k").has_value());
  EXPECT_FALSE(get_type_metadata("l").has_value());
  EXPECT_FALSE(get_type_metadata("m").has_value());
  EXPECT_FALSE(get_type_metadata("n").has_value());
}

TEST(CollectUnderTest, MatchWithNameDefs) {
  const std::string kProgram = R"(
fn f() -> u32 {
  let t = (u32:0, u32:1);
  match t {
    x => u32:0,
    (y, z) => u32:1,
  }
}
)";
  FileTable file_table;
  XLS_ASSERT_OK_AND_ASSIGN(auto module, ParseModule(kProgram, "fake_path.x",
                                                    "the_module", file_table));
  std::optional<Function*> f = module->GetFunction("f");
  ASSERT_TRUE(f.has_value());
  Statement* stmt = (*f.value()).body()->statements().back();
  auto* match_expr = std::get<Expr*>(stmt->wrapped());
  auto* match = down_cast<Match*>(match_expr);
  XLS_ASSERT_OK_AND_ASSIGN(std::vector<AstNode*> nodes,
                           CollectUnder(match, /*want_types=*/false));
  ASSERT_EQ(nodes.size(), 15);

  EXPECT_EQ(nodes[0]->ToString(), "t");
  EXPECT_EQ(nodes[0]->GetNodeTypeName(), "NameRef");

  EXPECT_EQ(nodes[1]->ToString(), "x");
  EXPECT_EQ(nodes[1]->GetNodeTypeName(), "NameDef");

  EXPECT_EQ(nodes[2]->ToString(), "x");
  EXPECT_EQ(nodes[2]->GetNodeTypeName(), "NameDefTree");

  EXPECT_EQ(nodes[3]->ToString(), "u32");
  EXPECT_EQ(nodes[3]->GetNodeTypeName(), "BuiltinTypeAnnotation");

  EXPECT_EQ(nodes[4]->ToString(), "u32:0");
  EXPECT_EQ(nodes[4]->GetNodeTypeName(), "Number");

  EXPECT_EQ(nodes[5]->ToString(), "x => u32:0");
  EXPECT_EQ(nodes[5]->GetNodeTypeName(), "MatchArm");

  EXPECT_EQ(nodes[6]->ToString(), "y");
  EXPECT_EQ(nodes[6]->GetNodeTypeName(), "NameDef");

  EXPECT_EQ(nodes[7]->ToString(), "y");
  EXPECT_EQ(nodes[7]->GetNodeTypeName(), "NameDefTree");

  EXPECT_EQ(nodes[8]->ToString(), "z");
  EXPECT_EQ(nodes[8]->GetNodeTypeName(), "NameDef");

  EXPECT_EQ(nodes[9]->ToString(), "z");
  EXPECT_EQ(nodes[9]->GetNodeTypeName(), "NameDefTree");

  EXPECT_EQ(nodes[10]->ToString(), "(y, z)");
  EXPECT_EQ(nodes[10]->GetNodeTypeName(), "NameDefTree");

  EXPECT_EQ(nodes[11]->ToString(), "u32");
  EXPECT_EQ(nodes[11]->GetNodeTypeName(), "BuiltinTypeAnnotation");

  EXPECT_EQ(nodes[12]->ToString(), "u32:1");
  EXPECT_EQ(nodes[12]->GetNodeTypeName(), "Number");

  EXPECT_EQ(nodes[13]->ToString(), "(y, z) => u32:1");
  EXPECT_EQ(nodes[13]->GetNodeTypeName(), "MatchArm");

  EXPECT_EQ(nodes[14]->ToString(),
            "match t {\n    x => u32:0,\n    (y, z) => u32:1,\n}");
  EXPECT_EQ(nodes[14]->GetNodeTypeName(), "Match");
}

// Tests that the ResolveLocalStructDef can see through transitive aliases.
TEST(ResolveLocalStructDef, StructDefInTransitiveAlias) {
  const std::string kProgram = R"(struct S {
}

type MyS1 = S;
type MyS2 = MyS1;
)";
  FileTable file_table;
  Scanner scanner(file_table, Fileno(0), kProgram);
  Parser parser("test", &scanner);
  XLS_ASSERT_OK_AND_ASSIGN(std::unique_ptr<Module> module,
                           parser.ParseModule());

  std::optional<ModuleMember*> maybe_my_s = module->FindMemberWithName("MyS2");
  ASSERT_TRUE(maybe_my_s.has_value());
  auto* type_alias = std::get<TypeAlias*>(*maybe_my_s.value());
  TypeAnnotation& aliased = type_alias->type_annotation();
  auto* type_ref_type_annotation =
      dynamic_cast<TypeRefTypeAnnotation*>(&aliased);
  ASSERT_NE(type_ref_type_annotation, nullptr);
  TypeDefinition td = type_ref_type_annotation->type_ref()->type_definition();

  XLS_ASSERT_OK_AND_ASSIGN(StructDef * resolved, ResolveLocalStructDef(td));

  std::optional<ModuleMember*> maybe_s = module->FindMemberWithName("S");
  ASSERT_TRUE(maybe_s.has_value());
  auto* s = std::get<StructDef*>(*maybe_s.value());
  EXPECT_EQ(s, resolved);
}

TEST(ContainedWithinFunctionTest, SampleInvocation) {
  const std::string_view kProgram = R"(
fn f() { () }
fn main() { f() }
)";
  FileTable file_table;
  XLS_ASSERT_OK_AND_ASSIGN(auto module, ParseModule(kProgram, "fake_path.x",
                                                    "the_module", file_table));
  Function* f = module->GetFunctionByName().at("f");
  Function* main = module->GetFunctionByName().at("main");
  const Statement* last_stmt = main->body()->statements().back();
  const Expr* last_expr = std::get<Expr*>(last_stmt->wrapped());
  const Invocation* call_f = down_cast<const Invocation*>(last_expr);

  // The function "main" has the call to f.
  ASSERT_TRUE(ContainedWithinFunction(*call_f, *main));

  // The function "f" does not have the call to f.
  ASSERT_FALSE(ContainedWithinFunction(*call_f, *f));
}

TEST(ContainedWithinFunctionTest, SampleBuiltinInvocation) {
  const std::string_view kProgram = R"(
fn main(x: u32, y: u32, z: u32) -> u32 { bit_slice_update(x, y, z) }
)";
  FileTable file_table;
  XLS_ASSERT_OK_AND_ASSIGN(auto module, ParseModule(kProgram, "fake_path.x",
                                                    "the_module", file_table));
  Function* main = module->GetFunctionByName().at("main");
  const Statement* last_stmt = main->body()->statements().back();
  const Expr* last_expr = std::get<Expr*>(last_stmt->wrapped());
  const Invocation* call = down_cast<const Invocation*>(last_expr);

  // The function "main" has the call to f.
  ASSERT_TRUE(ContainedWithinFunction(*call, *main));
}

TEST(ContainedWithinFunctionTest, InvocationWithinParametricExpression) {
  const std::string_view kProgram = R"(
fn id(x: u32) -> u32 { x }
fn f<X: u32, Y: u32 = {id(X)}>() -> u32 { Y }
)";
  FileTable file_table;
  XLS_ASSERT_OK_AND_ASSIGN(auto module, ParseModule(kProgram, "fake_path.x",
                                                    "the_module", file_table));
  Function* f = module->GetFunctionByName().at("f");
  const std::vector<ParametricBinding*>& parametric_bindings =
      f->parametric_bindings();
  ASSERT_EQ(parametric_bindings.size(), 2);
  const ParametricBinding* pb = parametric_bindings.at(1);
  const Invocation* call = down_cast<const Invocation*>(pb->expr());

  // The function "f" has the call to id() contained within its bounds.
  ASSERT_TRUE(ContainedWithinFunction(*call, *f));
}

}  // namespace
}  // namespace xls::dslx
