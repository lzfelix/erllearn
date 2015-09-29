 -module(signals_pingpong).
 -export([start/1, ping/2, pong/0]).

 ping(N, Pong_Pid) ->
     link(Pong_Pid),
     internal_ping(N, Pong_Pid).

internal_ping(0, _) ->
    exit(ping);

internal_ping(N, Pong_Pid) ->
    Pong_Pid ! {ping, self()},

    receive
        pong ->
            io:format("Ping received pong~n", [])
    end,

    internal_ping(N - 1, Pong_Pid).

pong() ->
    process_flag(trap_exit, true),
    internal_pong().

internal_pong() ->
    receive
        {ping, Ping_PID} ->
            io:format("Pong received ping~n", []),
            Ping_PID ! pong,
            pong();
        {'EXIT', From, Reason} ->
            io:format("Pong exiting, got ~p~n", [{'EXIT', From, Reason}])
    end.

start(Ping_Node) ->
    PongPID = spawn(signals_pingpong, pong, []),
    spawn(Ping_Node, signals_pingpong, ping, [10000, PongPID]).
