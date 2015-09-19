% Finds the biggest element in list using comprehension.
% Usage: listMax:find([10,20,5,2,2,2,100])
% 19-09-2015 QUT // Parallel Computing

-module(listMax).
-export([find_max/1]).

% Exposed function. It assumes that Head is the biggest element and proceeds
% to the rest of the list
find_max([Head | Rest]) ->
    find_max(Rest, Head).

% The list now is empty, so the carried element is the biggest. Return it.
find_max([],  Biggest) ->
    Biggest;

% The head element is bigger than the assumed biggest, update the value and go.
find_max([Head | Rest],  Biggest_so_far) when Head > Biggest_so_far ->
    find_max(Rest, Head);

% The head element is smaller. Simple proceeds to the next element
find_max([Head | Rest], Biggest_so_far) ->
    find_max(Rest, Biggest_so_far).
