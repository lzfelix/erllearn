%% Divides a message among processes. Each process prints a single letter.
%% 29-09-2015 QUT // Parallel Computing

-module(test).
-export([hi/0, print_char/1]).

hi() ->
    Phrase = "Hello parallel.",
    lists:map(fun spawner/1, Phrase),
    ok. % masks PIDs

spawner(Char) ->
    spawn(test, print_char, [Char]).

print_char(Char) ->
    io:format("~c~n", [Char]).
