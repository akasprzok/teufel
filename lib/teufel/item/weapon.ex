defmodule Teufel.Weapon do
  @moduledoc """
  Everything weapons!
  """

  alias Teufel.Weapon.{Prefix, Suffix}
  alias Teufel.Item.Rarity

  @type(attack_type :: :piercing, :blunt)

  @type t :: %__MODULE__{
          name: String.t(),
          level: pos_integer,
          attack: {attack_type(), Range.t()},
          scaling_factor: float(),
          prefix: nil | Prefix.t(),
          suffix: nil | Suffix.t(),
          rarity: nil | Rarity.t()
        }

  defstruct name: "Broken Sword",
            level: 0,
            attack: {:piercing, 1..2},
            scaling_factor: 1,
            prefix: nil,
            suffix: nil,
            rarity: nil

  def from_map(map) when is_map(map) do
    struct(%__MODULE__{}, map)
  end

  defimpl Teufel.Entity do
    alias Teufel.Weapon

    def to_stat_block(%Weapon{} = weapon) do
      weapon
      |> Map.from_struct()
      |> Map.put(:name, to_name(weapon))
      |> Map.drop([:prefix, :suffix, :rarity])
    end

    defp to_name(%Weapon{rarity: rarity, prefix: prefix, name: name, suffix: suffix}) do
      (to_name(rarity) <> to_name(prefix) <> name <> to_name(suffix))
      |> String.trim()
    end

    defp to_name(nil) do
      ""
    end

    defp to_name(%Prefix{name: name}) do
      name <> " "
    end

    defp to_name(%Suffix{name: name}) do
      " of " <> name
    end

    defp to_name(%Rarity{name: name}) do
      name <> " "
    end
  end
end
