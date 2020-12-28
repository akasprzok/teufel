defmodule Teufel.Weapon.Suffix do
  @moduledoc """
  A weapon can have a suffix that gives it additional stats/abilities.
  """
  @type stat :: :dexterity | :strength

  @type t :: %__MODULE__{
          name: String.t(),
          stat: {stat(), Range.t()}
        }

  defstruct name: "Strength",
            stat: {:strength, 1..2}

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
