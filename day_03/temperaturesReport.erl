% Converts a list of temperatures to oC (regardless of the previous format)
% and displays it.
% 19-09-2015 QUT // Parallel Computing

-module(temperaturesReport).
-export([format_temps/1]).

format_temps([]) ->
    ok;

% Recursively displays the temperature in each city in oC
format_temps([City | Rest]) ->
    print_temp(convert_to_celsius(City)),
    format_temps(Rest).

% Identity function if temp is already in oC. See the temperature conversor
% program on Day_02
convert_to_celsius({Name, {c, Temp}}) ->
    {Name, {c, Temp}};

convert_to_celsius({Name, {f, Temp}}) ->
    {Name, {c, (Temp - 32) * 5/9}}.

print_temp({Name, {c, Temp}}) ->
    io:format("~15w ~w c~n", [Name, Temp]).
