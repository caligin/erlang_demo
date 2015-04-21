-module(websocket_handler).
-behaviour(cowboy_websocket_handler).
-export([
    init/3,
    websocket_init/3,
    websocket_handle/3,
    websocket_info/3,
    websocket_terminate/3,
    message/1,
    greet/0,
    time_now/0
    ]).

init(_, _Req, _Opts) ->
    {upgrade, protocol, cowboy_websocket}.

websocket_init(_Type, Req, _Opts) ->
    {ok, _Tref} = timer:apply_interval(2000, ?MODULE, message, [self()]),
    {ok, Req, []}.

websocket_handle(_Frame, Req, State) ->
    {ok, Req, State}.    

websocket_info({data, Data}, Req, State) ->
    {reply, {binary, Data}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
    ok.    


message(Pid) ->
    Pid ! {data, greet()}.
    %Pid ! {data, time_now()}.
    %sensor_access:ask_state(Pid).

greet() ->
    <<"o hai!">>.

time_now() ->
    list_to_binary(io_lib:fwrite("~w",[time()])).

