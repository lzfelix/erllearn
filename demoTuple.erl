% Usage: demoTuple:convertLenght({centimeter, 100}), or inch in place of centimeter
% 16-09-2015 QUT // Parallel Computing

-module(demoTuple).
-export([convert_length/1]).

convert_length({centimeter, X}) ->
    {inch, X / 2.54};
convert_length({inch, Y}) ->
    {centimeter, Y * 2.54}.
