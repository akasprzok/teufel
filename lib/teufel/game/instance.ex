defmodule Teufel.Game.Instance do
  use GenServer

  alias Teufel.Game.{InstanceSupervisor, InstanceRegistry, Instance}

  defstruct player_id: nil

  @timeout 600_000

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %__MODULE__{}, opts)
  end

  @impl true
  def init(instance) do
    {:ok, instance, @timeout}
  end

  @impl true
  def handle_call(:instance, _from, instance) do
    {:reply, instance, instance, @timeout}
  end

  def new_instance(instance_id) do
    DynamicSupervisor.start_child(InstanceSupervisor, {Instance, name: via(instance_id)})
  end

  def via(instance_id) do
    {:via, Registry, {InstanceRegistry, instance_id}}
  end
end
