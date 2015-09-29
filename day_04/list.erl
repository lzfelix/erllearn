% A implementatio for fun to find the min element on a list
% 29-09-2015 QUT // Parallel Computing

-module(list).
-export([find_min/1]).

%%public declarations
find_min([]) ->
    nop;

find_min([Head | Rest]) ->
    find_min(Head, Rest).

%% private declarations
find_min(MinSoFar, []) ->
    MinSoFar;

find_min(MinSoFar, [Head | Rest]) when Head < MinSoFar ->
    find_min(Head, Rest);

find_min(MinSoFar, [Head | Rest]) ->
    find_min(MinSoFar, Rest).
