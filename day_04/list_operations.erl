%% A reduce (probably naive) implementation. Wow!
%%
%% Usage example:
%% $ F = fun(X, Y) -> X + Y end.
%% $ G = fun(X) -> X * X end.
%% $ L = [1,2,3,4,5,6,7,8,9,10].
%% list_operations:reduce(F, L).
%% map(G, L).
%%
%% 29-09-2015 QUT // Parallel Computing


-module(list_operations).
-export([reduce/2, map/2]).

reduce(F, [Head | Rest]) ->
    [Second | Tail] = Rest,
    reduce(F, Tail, F(Head, Second)).

reduce(F, [Head | Rest], Part) ->
    reduce(F, Rest, F(Head, Part));

reduce(F, [], Part) ->
    Part.



map(F, [Head | Rest]) ->
    L = map(F, Rest),
    [F(Head) | L];

map(F, []) ->
    [].
