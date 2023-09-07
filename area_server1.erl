-module(area_server1).
-export([loop/0, start/0, area/2]).

start() ->
  spawn(area_server1, loop, []).

area(Pid, What) ->
  rpc(Pid, What).

rpc(Pid, Request) ->
  Pid ! { self(), Request },
  receive
    {Pid, Response} ->
      Response
  end.

loop() ->
  receive
    {From, {rectangle, Width, Height}} ->
      From ! {self(), Width * Height},
      loop();
    {From, {circle, Radius}} ->
      From ! {self(), 3.14 * Radius * Radius},
      loop();
    {From, Other} ->
      From ! {self(),{error, Other}},
      loop()
  end.
