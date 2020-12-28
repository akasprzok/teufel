defmodule Teufel.WeaponGenTest do
  use ExUnit.Case

  alias Teufel.Weapon
  alias Teufel.Game.WeaponGen

  test "generate random weapon" do
    assert %Weapon{level: 0} = WeaponGen.generate()
  end

  test "generate specific level" do
    level = 69

    assert %Weapon{
             level: level
           } = WeaponGen.generate(level: level)
  end
end
