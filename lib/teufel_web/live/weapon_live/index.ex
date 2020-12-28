defmodule TeufelWeb.WeaponLive.Index do
  use TeufelWeb, :live_view

  require Logger

  alias Teufel.Entities
  alias Teufel.Game.WeaponGen

  @impl true
  def mount(_params, _session, socket) do
    weapon = WeaponGen.generate() |> Entities.to_display_block()
    {:ok, assign(socket, :weapon, weapon)}
  end

  @impl true
  def handle_event("generate", _, socket) do
    weapon = WeaponGen.generate() |> Entities.to_display_block()
    {:noreply, assign(socket, :weapon, weapon)}
  end
end
