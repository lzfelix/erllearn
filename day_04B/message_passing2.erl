%% Same as the previous program, but now the processes have registered names

-module(message_passing2).
-export([start/0, ping/1, pong/0]).

ping(0) ->
    pong ! finished,
    io:format("Ping finished~n", []);

ping(N) ->
    pong ! {ping, self()},

    receive
        pong ->
            io:format("Ping received pong~n", [])
    end,

    ping(N - 1).

pong() ->
    receive
        finished ->
            io:format("Pong finished~n", []);
        {ping, Ping_PID} ->
            io:format("Pong received ping~n", []),
            Ping_PID ! pong,
            pong()
    end.

start() ->
    % registering process under "pong" name
    register(pong, spawn(message_passing2, pong, [])),
    spawn(message_passing2, ping, [3]).
