-module(try_test).
-export([demo1/0, demo2/0]).

generate(1) -> a;
generate(2) -> throw(a);
generate(3) -> exit(a);
generate(4) -> {'EXIT', a};
generate(5) -> error(a).


demo1() ->
  [catcher(N) || N <- [1, 2, 3, 4, 5]].

catcher(N) ->
  try generate(N) of
    Val -> {N, normal, Val}
  catch
    throw:X -> {N, caught, thrown, X};
    exit:X -> {N, caught, exited, X};
    error:X -> {N, caught, error, X}
  end.

demo2() ->
  [{I, (catch generate(I))} || I <- [1,2,3,4,5]].

% demo3() ->
%   try generate(5)
%   catch
%     error:X -> {X, erlang:get_stacktrace()}
%   end.
