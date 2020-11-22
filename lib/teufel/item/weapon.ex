defmodule Teufel.Item.Weapon do
  @moduledoc """
  Everything weapons!
  """

  alias Teufel.Item
  alias Teufel.Item.Weapon.{Prefix, Suffix}
  alias Teufel.Item.Rarity

  @type t :: %__MODULE__{
          name: String.t(),
          type: atom(),
          level: pos_integer,
          attack_min: float(),
          attack_max: float(),
          scaling_factor: float(),
          prefix: nil | Prefix.t(),
          suffix: nil | Suffix.t(),
          rarity: Rarity.t()
        }

  defstruct Item.common_fields() ++
            [
            type: :weapon,
            attack_min: 1,
            attack_max: 2,
            scaling_factor: 1,
            prefix: nil,
            suffix: nil,
            rarity: %Rarity{}
            ]

  def from_map(map) when is_map(map) do
    struct(%__MODULE__{}, map)
  end

  @spec calculate_attack(t()) :: {float(), float()}
  def calculate_attack(%__MODULE__{
        attack_min: attack_min,
        attack_max: attack_max,
        scaling_factor: scaling_factor,
        level: level
      }) do
    calculated_attack_min = attack_min + scaling_factor * level
    calculated_attack_max = attack_max + scaling_factor * level

    {calculated_attack_min, calculated_attack_max}
  end

  @spec to_display(t()) :: map()
  def to_display(
        %__MODULE__{
          level: level,
        } = weapon
      ) do
    {calculated_attack_min, calculated_attack_max} = calculate_attack(weapon)

    %{
      "Name" => to_name(weapon),
      "Level" => level,
      "Attack" => "#{calculated_attack_min}-#{calculated_attack_max}"
    }
  end

  defp to_name(%__MODULE__{rarity: rarity, prefix: prefix, name: name, suffix: suffix}) do
    to_name(rarity) <> to_name(prefix) <> name <> to_name(suffix)
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
