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
#

PATH=/usr/local/bin:/usr/bin:/bin:/sbin:/usr/bin/X11:/usr/sbin:/usr/lib/postgresql/bin/:$HOME/bin:/usr/games/:/usr/lib/openoffice/program/
export PATH

# Emacs lisp
export PATH="$HOME/.cask/bin:$PATH"
export PATH="$HOME/.evm/bin:$PATH"

# Golang
export GOROOT=$HOME/Apps/go
export GOPATH=$HOME/Apps/golang
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# Rust
export RUST_SRC_PATH=$HOME/Apps/rust/src
export PATH=$PATH:$RUST_SRC_PATH/usr/local/bin
export PATH=$PATH:$HOME/.cargo/bin/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$RUST_SRC_PATH/usr/local/lib

# Erlang
export ERLANG_HOME=$HOME/Apps/otp_src
export PATH=$PATH:$ERLANG_HOME/bin/

# Java
export JAVA_HOME=$APPS/jre
export PATH=$PATH:$JAVA_HOME/bin

export MAVEN_HOME=$APPS/apache-maven
export PATH=$PATH:$MAVEN_HOME/bin

export ANT_HOME=$APPS/apache-ant
export PATH=$PATH:$ANT_HOME/bin# LIBs and LD_LIBRARY_PATH

if [ -d "${usr_local}/lib" ]; then
    LD_LIBRARY_PATH="$usr_local/lib:$LD_LIBRARY_PATH"
fi

if [ -d "${home_local}/lib" ]; then
    LD_LIBRARY_PATH="${home_local}/lib:$LD_LIBRARY_PATH"
fi

if [ -d /usr/lib/x86_64-linux-gnu ]; then
    LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
fi

export LD_LIBRARY_PATH
