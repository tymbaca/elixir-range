defmodule StupidSystemTest do
  use ExUnit.Case
  doctest StupidSystem

  test "greets the world" do
    assert StupidSystem.hello() == :world
  end
end
