-module(demo_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatcher = cowboy_router:compile([
        {'_', [
            {"/", cowboy_static, {priv_file, demo, "index.html"}},
            {"/websocket", websocket_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_http(cowboy_ref, 100, [{port, 8080}], [ {env, [{dispatch, Dispatcher}]} ]),
    SupervisorRef = demo_sup:start_link(),
    SupervisorRef.

stop(_State) ->
	ok.

