defmodule TeufelWeb.WeaponController do
  use TeufelWeb, :controller

  alias Teufel.Game.WeaponGen

  def index(conn, _params) do
    weapon_config = WeaponGen.list_config()
    render(conn, "index.html", weapon_config: weapon_config)
  end
end
