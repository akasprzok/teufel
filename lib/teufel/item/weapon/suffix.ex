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

  def to_display(nil, _scaling_factor, _level), do: []

  def to_display(%__MODULE__{stat: stat} = suffix, scaling_factor, level) do
    {stat_min, stat_max} = calculate_stat(suffix, scaling_factor, level)

    [
      {stat_name(stat), "#{stat_min}-#{stat_max}"}
    ]
  end
  def calculate_stat(%__MODULE__{
        stat_min: stat_min,
        stat_max: stat_max
  },
        scaling_factor,
        level
      ) do
    calculated_stat_min = stat_min + scaling_factor * level
    calculated_stat_max = stat_max + scaling_factor * level

    {calculated_stat_min, calculated_stat_max}
  end

  defp stat_name(stat) when is_atom(stat) do
    Atom.to_string(stat) |> String.capitalize()
  end
end
