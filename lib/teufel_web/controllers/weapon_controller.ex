defmodule TeufelWeb.WeaponController do
  use TeufelWeb, :controller

  alias Teufel.Game.WeaponGen
  alias Teufel.{Entities, Weapon}

  def index(conn, _params) do
    weapon_config =
      WeaponGen.list_config() |> Map.fetch!(:weapons) |> Enum.map(&Entities.to_display_block/1)

    headers = extract_headers(weapon_config)

    render(conn, "index.html", weapon_config: weapon_config, headers: headers)
  end

  defp extract_headers(weapons) do
    weapons
    |> List.first()
    |> Enum.map(fn {k, _v} -> k end)
  end
end
