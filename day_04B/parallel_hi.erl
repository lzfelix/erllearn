-module(parallel_hi).
-export([start/0, say_something/2]).

say_something(What, 0) ->
    done;

say_something(What, Times) ->
    io:format("~p~n", [What]),
    say_something(What, Times - 1).

start() ->
    spawn(parallel_hi, say_something, [goodbye, 3]),
    spawn(parallel_hi, say_something, [hello, 3]).
