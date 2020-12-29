defmodule Teufel.Game do
  use Supervisor

  alias Teufel.Game.WeaponGen

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      WeaponGen,
      {Registry, keys: :unique, name: Teufel.Game.InstanceRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: Teufel.Game.InstanceSupervisor}
    ]

    Supervisor.init(children, strategy: :one_for_one, name: Teufel.Game.Supervisor)
  end
end
