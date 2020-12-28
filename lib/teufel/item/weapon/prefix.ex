defmodule Teufel.Weapon.Prefix do
  @moduledoc """
  A weapon can have a prefix that gives it additional stats/abilities.
  """
  @type stat :: :fire_damage | :ice_damage

  @type t :: %__MODULE__{
          name: String.t(),
          stat: {stat(), Range.t()}
        }

  defstruct name: "Fiery",
            stat: {:fire_damage, 1..2}

  def from_map(map) when is_map(map) do
    struct(%__MODULE__{}, map)
  end

  defimpl Teufel.Entity do
    alias Teufel.Weapon.Prefix

    def to_stat_block(%Prefix{} = prefix) do
      prefix
      |> Map.from_struct()
    end
  end
end
