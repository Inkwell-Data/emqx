%%--------------------------------------------------------------------
%% Copyright (c) 2020-2023 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_otel_app).

-behaviour(application).

-export([start/2, stop/1]).
-export([stop_deps/0]).

start(_StartType, _StartArgs) ->
    emqx_otel_config:add_handler(),
    ok = emqx_otel_config:add_otel_log_handler(),
    emqx_otel_sup:start_link().

stop(_State) ->
    emqx_otel_config:remove_handler(),
    _ = emqx_otel_config:remove_otel_log_handler(),
    ok.

stop_deps() ->
    emqx_otel_config:stop_all_otel_apps().
