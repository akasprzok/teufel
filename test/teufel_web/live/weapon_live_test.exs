defmodule TeufelWeb.WeaponLiveTest do
  use TeufelWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Show" do
    test "displays weapon", %{conn: conn} do
      {:ok, show_live, html} = live(conn, Routes.weapon_index_path(conn, :new))

      assert html =~ "Weapon Generator"
      assert html =~ "Name"

      assert show_live |> element("button") |> has_element?()
    end

    test "generate weapon", %{conn: conn} do
      {:ok, show_live, _html} = live(conn, Routes.weapon_index_path(conn, :new))

      new_html = show_live |> element("button") |> render_click()

      assert new_html =~ "Weapon Generator"
      assert new_html =~ "Name"
    end
  end
end
