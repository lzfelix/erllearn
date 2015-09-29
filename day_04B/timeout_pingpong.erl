%% This new version kills pong when it times out, which can happen
%% either when ping finishes it iterations, of if it stops answering
%% for 5 seconds or more.

-module(timeout_pingpong).
-export([start_ping/1, start_pong/0, ping/2, pong/0]).

ping(0, Pong_Node) ->
    io:format("Ping finished~n", []);

ping(N, Pong_Node) ->
    {pong, Pong_Node} ! {ping, self()},
    receive
        pong ->
            io:format("Ping received pong~n", [])
    end,
    ping(N - 1, Pong_Node).

pong() ->
    receive
        {ping, Ping_PID} ->
            io:format("Pong received ping~n", []),
            Ping_PID ! pong,
            pong()
        after 50000 ->
            io:format("Pong timed out~n", [])
    end.

start_pong() ->
    register(pong, spawn(timeout_pingpong, pong, [])).

start_ping(Pong_Node) ->
    spawn(timeout_pingpong, ping, [3, Pong_Node]).
