-module(user_default).
-compile(export_all).

hello() ->
  "hello".

away(Time) ->
  io:format("Joe is away and will be back in ~w miniutes~n", [Time]).
