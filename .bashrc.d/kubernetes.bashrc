#!/usr/bin/env bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

K8S_BINARIES=("kubectl")

for BIN in ${K8S_BINARIES[@]}; do
  if $(which ${BIN} > /dev/null 2>&1); then
    source <(${BIN} completion bash)
  fi
done

alias kci="kubectl cluster-info"

alias ksvcs='kubectl get services --sort-by=.metadata.name -o wide'

alias kpods="kubectl get pods -o wide"
alias kpodsko="kubectl get pods --sort-by='.status.containerStatuses[0].restartCount -o wide"
