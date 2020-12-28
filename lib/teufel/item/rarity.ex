defmodule Teufel.Item.Rarity do
  @moduledoc """
  Every item has a rarity.
  """

  @type t :: %__MODULE__{
          name: String.t(),
          weight: integer()
        }

  defstruct name: "Ordinary",
            weight: 10

  def from_map(map) when is_map(map) do
    struct(%__MODULE__{}, map)
  end
end
