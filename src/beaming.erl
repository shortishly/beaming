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


-module(beaming).


-export([export_all/1]).
-export([exports/1]).
-export([functions/1]).


%% @returns all functions in module
-spec functions(module()) -> [function()].
functions(M) ->
    [fun M:F/A || {function, _, F, A, _} <- abstract_code(code:which(M))].


%% @returns all exported functions in a module
-spec exports(module()) -> [function()].
exports(M) ->
    [fun M:F/A || {F, A} <- M:module_info(exports), F /= module_info].


export_all(M) ->
    case code:module_status(M) of
        modified ->
            ok;

        Otherwise when Otherwise == not_loaded; Otherwise == loaded ->
            {module, M} = ?FUNCTION_NAME(M, code:which(M)),
            ok
    end.


export_all(M, Filename) ->
    {ok, M, Compiled} = compile:forms(abstract_code(Filename), [export_all]),
    code:load_binary(M, Filename, Compiled).


abstract_code(Filename) ->
    {ok, {_, [{_, {_, AbstractCode}}]}} = beam_lib:chunks(
                                            Filename,
                                            [abstract_code]),
    AbstractCode.
