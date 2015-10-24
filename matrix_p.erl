-module(matrix_p).
-export([multiply/2, p_multiply_row_by_col/3]).

transpose([[]|_]) ->
    [];
transpose(B) ->
  [lists:map(fun hd/1, B) | transpose(lists:map(fun tl/1, B))].


red(Pair, Sum) ->
    X = element(1, Pair),   %gets X
    Y = element(2, Pair),   %gets Y
    X * Y + Sum.

%% Mathematical dot product. A x B = d
%% A, B = 1-dimension vector
%% d    = scalar
dot_product(A, B) ->
    lists:foldl(fun red/2, 0, lists:zip(A, B)).


%% Exposed function. Expected result is C = A x B.
multiply(A, B) ->
    %% First transposes B, to facilitate the calculations (It's easier to fetch
    %% row than column wise).
    register(aggregator, self()),
    multiply_internal(A, transpose(B), 0),
    postman(0, length(A)).

postman(SenderId, MaxId) when SenderId < MaxId ->
    receive
        {SenderId, List} -> ok
    end,

    [List | postman(SenderId + 1, MaxId)];

postman(_, _) ->
    unregister(aggregator),
    [].

%% Spawns threads to multiply each column
multiply_internal([Head | Rest], B, Id) ->
    % multiply each row by Y
    spawn(matrix_p, p_multiply_row_by_col, [Head, B, Id]),
    multiply_internal(Rest, B, Id + 1);

%% recursion end
multiply_internal([], B, Id) ->
    ok.


p_multiply_row_by_col(Row, Cols, Id) ->
    List = multiply_row_by_col(Row, Cols, Id),
    aggregator ! {Id, List}.


multiply_row_by_col(Row, [Col_Head | Col_Rest], Id) ->
    Scalar = dot_product(Row, Col_Head),
    [Scalar | multiply_row_by_col(Row, Col_Rest, Id)];

multiply_row_by_col(Row, [], Id) ->
    [].
