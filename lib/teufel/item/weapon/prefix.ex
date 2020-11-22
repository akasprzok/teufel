defmodule Teufel.Item.Weapon.Prefix do
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

  def to_display(%__MODULE__{stat: stat, stat_min: stat_min, stat_max: stat_max}, level, scaling_factor) do

  end
end
