defmodule WeaponStoreTest do
  use ExUnit.Case
  doctest WeaponStore

  test "greets the world" do
    assert WeaponStore.hello() == :world
  end
end
