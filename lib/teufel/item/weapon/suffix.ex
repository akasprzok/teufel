defmodule Teufel.Item.Weapon.Suffix do
  @moduledoc """
  A weapon can have a suffix that gives it additional stats/abilities.
  """
  @type stat :: :dexterity | :strength

  @type t :: %__MODULE__{
          name: String.t(),
          stat_min: float(),
          stat_max: float(),
          stat: stat()
        }

  defstruct name: "Strength",
            stat_min: 1,
            stat_max: 2,
            stat: :strength

  def from_map(map) when is_map(map) do
    struct(%__MODULE__{}, map)
  end
end
