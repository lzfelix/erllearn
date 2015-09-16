% Mixes two collours into a new one.
% Usage: create a colour by invoking new(R,G,B,A). This is going to yield a map.
%        combine the colours using blend()/2.
%
% This is a difficult code =S
% 16-09-2015 QUT // Parallel Computing

-module (color).

% new creates a new RGBA color and blend mixes two RGBA colours
-export([new/4, blend/2]).

% defining a macro, andalso is the short-circuit AND
-define(is_channel(V), (is_float(V) andalso V >= 0.0 andalso V =< 1.0)).

new(R,G,B,A) when ?is_channel(R), ?is_channel(G), 
                  ?is_channel(B), ?is_channel(A) ->

    #{red => R, green => G, blue => B, alpha => A}.

blend(Src, Dst) ->
    % What happens is: call the alpha function over the alpha components.
    % Following it calls the next blend, as the next one has three parameters.
    blend(Src, Dst, alpha(Src, Dst)).

blend(Src, Dst, Alpha) when Alpha > 0.0 ->
    % This block is only going to be executed, if Alpha > 0., othewise goes to
    % the next one

    % The := operator either updates a map key or retrieve its value (when LHS isn't assigned)
    Dst#{
        red   := red(Src, Dst) / Alpha,
        green := green(Src, Dst) / Alpha,
        blue  := blue(Src, Dst) / Alpha,
        alpha := Alpha
    };

% Underscores are used to ignore parameters
blend(_, Dst, _) ->
    % This is just a syntax for saying: "hey, update this map's keys.
    Dst#{
        red := 0.0,
        green := 0.0,
        blue := 0.0,
        alpha := 0.0
    }.

% This function combines two different alphas using some weird formula.
% And now := means reverse assignment =)
alpha(#{red := SA}, #{alpha := DA}) ->
    SA + DA * (1.0 - SA).

% Other blending function
red(#{red := SV, alpha := SA}, #{red := DV, alpha := DA}) ->
    SV*SA + DV*DA*(1.0 - SA).
green(#{green := SV, alpha := SA}, #{green := DV, alpha := DA}) ->
    SV*SA + DV*DA*(1.0 - SA).
blue(#{blue := SV, alpha := SA}, #{blue := DV, alpha := DA}) ->
    SV*SA + DV*DA*(1.0 - SA).
