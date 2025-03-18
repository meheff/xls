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

#ifndef XLS_SYNTHESIS_CREDENTIALS_H_
#define XLS_SYNTHESIS_CREDENTIALS_H_

#include <memory>

#include "grpcpp/security/credentials.h"
#include "grpcpp/security/server_credentials.h"

namespace xls {
namespace synthesis {

std::shared_ptr<::grpc::ServerCredentials> GetServerCredentials();
std::shared_ptr<::grpc::ChannelCredentials> GetChannelCredentials();

}  // namespace synthesis
}  // namespace xls

#endif  // XLS_SYNTHESIS_CREDENTIALS_H_
