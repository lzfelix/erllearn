% A simple temperature converter
% Usage: conv({city, {scale, temp}}). Where scale is [c]elsius of [f]arenheit
% 16-09-2015 QUT // Parallel Computing

-module(temperature).
-export([conv/1]).

conv({City, {c, T}}) ->
    {City, {f, T * 1.8 + 32}};

conv({City, {f, T}}) ->
    {City, {c, (T - 32) / 1.8}}.

