defprotocol Teufel.Character do
  alias Teufel.Attack

  @spec take_damage(Attack.t()) :: :ok | :dead
  def take_damage(attack)
end
