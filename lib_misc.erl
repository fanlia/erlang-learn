-module(lib_misc).
-export([for/3, qsort/1, pythag/1, perms/1, max/2, filter/2, odds_and_evens1/1, odds_and_evens2/1, sqrt/1,
         sleep/1,
         flush_buffer/0,
         priority_receive/0
]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].

qsort([]) -> [];
qsort([Pivot|T]) ->
  qsort([X || X <- T, X < Pivot ])
  ++ [Pivot]
  ++ qsort([X || X <- T, X >= Pivot ]).


pythag(N) ->
  [{A, B, C} || 
    A <- lists:seq(1, N),
    B <- lists:seq(1, N),
    C <- lists:seq(1, N),
    A =< B,
    B =< C,
    A + B + C =< N,
    A*A + B*B =:= C*C
  ].

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L -- [H])].

max(X, Y) when X > Y -> X;
max(_, Y) -> Y.

filter(P, [H, T]) ->
  case P(H) of
    true -> [H|filter(P, T)];
    false -> filter(P, T)
  end;
filter(_, []) -> [].

odds_and_evens1(L) ->
  Odds = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.

odds_and_evens2(L) ->
  odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;
odds_and_evens_acc([], Odds, Evens) ->
  {lists:reverse(Odds), lists:reverse(Evens)}.

% count_characters(Str) ->
%   count_characters(Str, #{}).
%
% count_characters([H|T], #{H := 1}=X) ->
%   count_characters(T, X#{ H:= 1 + 1});
% count_characters([H|T], X) ->
%   count_characters(T, X#{H => 1});
% count_characters([], X) ->
%   X.

sqrt(X) when X < 0 ->
  error({squareRootNegtiveArgument, X});
sqrt(X) ->
  math:sqrt(X).

sleep(T) ->
  receive
  after T ->
          true
  end.

flush_buffer() ->
  receive
    _Any ->
      flush_buffer()
  after 0 ->
    true
  end.

priority_receive() ->
  receive
    {alarm, X} ->
      {alarm, X}
  after 0 ->
    receive
      Any ->
        Any
    end
  end.
