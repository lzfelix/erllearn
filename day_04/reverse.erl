%% Simply reverses a List
%% 29-09-2015 QUT // Parallel Computing

 -module(reverse).
 -export([reverse/1]).

 reverse(List) ->
     reverse(List, []).

%% The | operator can be used to concatenate >objects< into lists
reverse([Head | Rest], Reversed) ->
    reverse(Rest, [Head | Reversed]);

reverse([], Reversed) ->
    Reversed.
