defmodule Teufel.Game do
  use Supervisor

  alias Teufel.Game.WeaponGen

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      WeaponGen
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
