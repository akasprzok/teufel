defmodule TeufelWeb.WeaponControllerTest do
  use TeufelWeb.ConnCase

  describe "index" do
    test "lists all weapons", %{conn: conn} do
      conn = get(conn, Routes.weapon_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Weapons"
    end
  end
end
