-module(sensor_access).
-behaviour(gen_server).

%% API.
-export([start_link/0]).
-export([ask_state/1]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).


%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

ask_state(Pid) ->
    gen_server:cast(?MODULE, {sensor_value, Pid}).

%% gen_server.

init([]) ->
	{ok, 0}.

handle_call(_Request, _From, State) ->
	{reply, ignored, State}.

handle_cast({sensor_value, Pid}, State) ->
    Pid ! {data, integer_to_binary(State)},
    {noreply, State + 1};
handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.
