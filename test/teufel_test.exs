defmodule TeufelTest do
  use ExUnit.Case
  doctest Teufel

  test "greets the world" do
    assert Teufel.hello() == :world
  end
end
