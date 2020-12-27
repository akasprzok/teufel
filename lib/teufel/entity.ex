defprotocol Teufel.Entity do
  @moduledoc """
  The Entity protocol should be implemented for most any Teufel struct that represents an in-game entity. This includes items at large, but also player and non-player characters.
  """

  @type display_block :: [{String.t(), String.t()}]

  @type stat_block :: keyword()

  @doc """
  Returns a "display block" in the form of a list containing {String.t(), String.t()} tuples. This is for display to the user - no further processing of the stat_block is expected.

  Legibility should be paramount. Instead of separate values for, i.e., attack_min and attack_max, the tuple {"Attack", "15-25"} should be substituted.
  """
  @spec to_display(term()) :: display_block()
  def to_display(entity)
end
