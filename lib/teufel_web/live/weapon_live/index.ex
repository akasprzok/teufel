defmodule TeufelWeb.WeaponLive.Index do
  use TeufelWeb, :live_view

  require Logger

  alias Teufel.Entity
  alias Teufel.Game.WeaponGen

  @impl true
  def mount(_params, _session, socket) do
    weapon = WeaponGen.generate() |> Entity.to_display()
    {:ok, assign(socket, :weapon, weapon)}
  end

  @impl true
  def handle_event("generate", _, socket) do
    weapon = WeaponGen.generate() |> Entity.to_display()
    {:noreply, assign(socket, :weapon, weapon)}
  end
end
