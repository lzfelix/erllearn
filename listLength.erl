% Finding the size of a list using list operators
% Usage: listLength:len([1,2,3,4,5,6,7,8,9,0[).
% 16-09-2015 QUT // Parallel Computing

-module(listLength).
-export([len/1]).

len([]) ->
    0;
len([First | Rest]) ->
    1 + len(Rest).


