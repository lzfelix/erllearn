% Simple example of using the output function. No big deal.
% Usage: figure it out.
% 19-09-2015 QUT // Parallel Computing

-module(printDemo).

-export([sayHi/0]).

sayHi() ->
    io:format("Hi~n", []).
