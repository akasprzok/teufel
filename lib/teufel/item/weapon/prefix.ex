defmodule Teufel.Weapon.Prefix do
  @moduledoc """
  A weapon can have a prefix that gives it additional stats/abilities.
  """
  @type stat :: :fire_damage | :ice_damage

  @type t :: %__MODULE__{
          name: String.t(),
          stat_min: float(),
          stat_max: float(),
          stat: stat()
        }

  defstruct name: "Fiery",
            stat_min: 1,
            stat_max: 2,
            stat: :fire_damage

  def from_map(map) when is_map(map) do
    struct(%__MODULE__{}, map)
  end

  defimpl Teufel.Entity do
    alias Teufel.Weapon.Prefix

    def to_display(%Prefix{name: name, stat_min: stat_min, stat_max: stat_max, stat: stat}, level \\ 0) do
      [
        {"Name", name},
        {"Level", level},
        {"Stat", stat},
        {"Modifier", "#{stat_min}-#{stat_max}"}
      ]
    end
  end
end
