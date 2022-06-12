%% Copyright (c) 2022 Peter Morgan <peter.james.morgan@gmail.com>
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.


-module(beaming_tests).


-include_lib("eunit/include/eunit.hrl").


functions_test() ->
    ?assertEqual(
       [fun beaming:abstract_code/1,
        fun beaming:export_all/1,
        fun beaming:export_all/2,
        fun beaming:exports/1,
        fun beaming:exports_mfa/1,
        fun beaming:functions/1,
        fun beaming:functions_mfa/1,
        fun beaming:functions_tspec/1],
       lists:sort(beaming:functions(beaming))).


functions_mfa_test() ->
    ?assertEqual(
       [{beaming, abstract_code, 1},
        {beaming, export_all, 1},
        {beaming, export_all, 2},
        {beaming, exports, 1},
        {beaming, exports_mfa, 1},
        {beaming, functions, 1},
        {beaming, functions_mfa, 1},
        {beaming, functions_tspec, 1}],
       lists:sort(beaming:functions_mfa(beaming))).


functions_tspec_test() ->
    ?assertEqual(
       [{beaming, abstract_code, '_'},
        {beaming, export_all, '_'},
        {beaming, export_all, '_'},
        {beaming, exports, '_'},
        {beaming, exports_mfa, '_'},
        {beaming, functions, '_'},
        {beaming, functions_mfa, '_'},
        {beaming, functions_tspec, '_'}],
       lists:sort(beaming:functions_tspec(beaming))).


exports_test() ->
    ?assertEqual(
       [fun beaming:export_all/1,
        fun beaming:exports/1,
        fun beaming:exports_mfa/1,
        fun beaming:functions/1,
        fun beaming:functions_mfa/1,
        fun beaming:functions_tspec/1],
       lists:sort(beaming:exports(beaming))).


exports_mfa_test() ->
    ?assertEqual(
       [{beaming, export_all, 1},
        {beaming, exports, 1},
        {beaming, exports_mfa, 1},
        {beaming, functions, 1},
        {beaming, functions_mfa, 1},
        {beaming, functions_tspec, 1}],
       lists:sort(beaming:exports_mfa(beaming))).


export_all_test() ->
    ?assertEqual([fun beaming_mut:f/0], beaming:exports(beaming_mut)),
    ?assertEqual("hello world", beaming_mut:f()),
    ?assertException(error, undef, beaming_mut:g()),
    ?assertEqual(ok, beaming:export_all(beaming_mut)),
    ?assertEqual(
       [fun beaming_mut:g/0,
        fun beaming_mut:f/0],
       beaming:exports(beaming_mut)),
    ?assertEqual("hello world", beaming_mut:f()),
    ?assertEqual("world", beaming_mut:g()).
