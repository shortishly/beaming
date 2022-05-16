#-*- mode: makefile-gmake -*-
# Copyright (c) 2022 Peter Morgan <peter.james.morgan@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
PROJECT = beaming

RELX_TAR = 0

BUILD_DEPS = elvis_mk
DEP_PLUGINS = elvis_mk

dep_elvis_mk = git https://github.com/inaka/elvis.mk.git 1.0.0

PLT_APPS = \
	compiler \
	crypto \
	mnesia \
	runtime_tools \
	stdlib \
	syntax_tools \
	tools

include erlang.mk

all:: elvis dialyze eunit docs