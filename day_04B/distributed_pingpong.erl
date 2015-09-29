%% Distribubed version of ping pong communication. In order to make this work,
%% create a magic cookie on the home folder named .erlang.cookie with a shared
%% secred word (atom).
%%
%% Then start two shells (can even be on the same computer) with:
%% $ erl -sname <shell_name>. If the computers aren't under the same IP docmain,
%% replace -sname by -name and inform the full IP path.
%% on one shell run start_pong(), on the other run
%% start_ping(<other_shell_name>@<other_computer_name) Eg: start_ping(Albert@MyPC).


-module(distributed_pingpong).

-export([start_ping/1, start_pong/0,  ping/2, pong/0]).

ping(0, Pong_Node) ->
    {pong, Pong_Node} ! finished,
    io:format("ping finished~n", []);

ping(N, Pong_Node) ->
    {pong, Pong_Node} ! {ping, self()},
    receive
        pong ->
            io:format("Ping received pong~n", [])
    end,
    ping(N - 1, Pong_Node).

pong() ->
    receive
        finished ->
            io:format("Pong finished~n", []);
        {ping, Ping_PID} ->
            io:format("Pong received ping~n", []),
            Ping_PID ! pong,
            pong()
    end.

start_pong() ->
    register(pong, spawn(distributed_pingpong, pong, [])).

start_ping(Pong_Node) ->
    spawn(distributed_pingpong, ping, [3, Pong_Node]).
