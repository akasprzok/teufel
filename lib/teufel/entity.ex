defprotocol Teufel.Entity do
  @moduledoc """
  The Entity protocol should be implemented for most any Teufel struct that represents an in-game entity. This includes items at large, but also player and non-player characters.
  """

  @type stat_block :: %{atom() => String.t() | {String.t(), Range.t()}}

  @type display_block :: [{String.t(), String.t()}]

  @doc """
  Returns a "stat block" in the form of a list containing {String.t(), String.t()} tuples. This is for display to the user - no further processing of the stat_block is expected.

  Legibility should be paramount. Instead of separate values for, i.e., attack_min and attack_max, the tuple {"Attack", "15-25"} should be substituted.
  """
  @spec to_stat_block(term()) :: stat_block()
  def to_stat_block(entity)
end

defmodule Teufel.Entities do
  alias Teufel.Entity

  @spec to_display_block(Entity.t()) :: Entity.display_block()
  def to_display_block(entity) do
    entity
    |> Entity.to_stat_block()
    |> Enum.map(&stat_to_string/1)
    |> Enum.sort()
  end

  defp stat_to_string({stat, {value_type, value}}) do
    {stat_to_string(stat), "#{to_string(value)} #{to_string(value_type)}"}
  end

  defp stat_to_string({stat, value}) do
    {stat_to_string(stat), stat_to_string(value)}
  end

  defp stat_to_string(atom) when is_atom(atom) do
    atom |> Atom.to_string() |> Recase.to_title()
  end

  defp stat_to_string(term) do
    to_string(term)
  end
end
