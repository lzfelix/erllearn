%To run -> demo:funName(args).

-module(demo).

% The thing after / is called arity. A function can be redeclared with different arities
-export([fac/1, convert/2]).

fac(1) ->
    1;
fac(N) ->
    N * fac(N - 1).

% Atom example, pass inch or centimeter for different conversion. The atom is called clause, 
% on this case.
convert(M, inch) ->
    M / 2.54;

convert(M, centimeter) ->
    M * 2.54.


