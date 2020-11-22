defmodule TeufelWeb.WeaponLiveTest do
  use TeufelWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Teufel.Item

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:weapon) do
    {:ok, weapon} = Item.create_weapon(@create_attrs)
    weapon
  end

  defp create_weapon(_) do
    weapon = fixture(:weapon)
    %{weapon: weapon}
  end

  describe "Index" do
    setup [:create_weapon]

    test "lists all weapons", %{conn: conn, weapon: weapon} do
      {:ok, _index_live, html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert html =~ "Listing Weapons"
    end

    test "saves new weapon", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert index_live |> element("a", "New Weapon") |> render_click() =~
               "New Weapon"

      assert_patch(index_live, Routes.weapon_index_path(conn, :new))

      assert index_live
             |> form("#weapon-form", weapon: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#weapon-form", weapon: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.weapon_index_path(conn, :index))

      assert html =~ "Weapon created successfully"
    end

    test "updates weapon in listing", %{conn: conn, weapon: weapon} do
      {:ok, index_live, _html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert index_live |> element("#weapon-#{weapon.id} a", "Edit") |> render_click() =~
               "Edit Weapon"

      assert_patch(index_live, Routes.weapon_index_path(conn, :edit, weapon))

      assert index_live
             |> form("#weapon-form", weapon: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#weapon-form", weapon: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.weapon_index_path(conn, :index))

      assert html =~ "Weapon updated successfully"
    end

    test "deletes weapon in listing", %{conn: conn, weapon: weapon} do
      {:ok, index_live, _html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert index_live |> element("#weapon-#{weapon.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#weapon-#{weapon.id}")
    end
  end

  describe "Show" do
    setup [:create_weapon]

    test "displays weapon", %{conn: conn, weapon: weapon} do
      {:ok, _show_live, html} = live(conn, Routes.weapon_show_path(conn, :show, weapon))

      assert html =~ "Show Weapon"
    end

    test "updates weapon within modal", %{conn: conn, weapon: weapon} do
      {:ok, show_live, _html} = live(conn, Routes.weapon_show_path(conn, :show, weapon))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Weapon"

      assert_patch(show_live, Routes.weapon_show_path(conn, :edit, weapon))

      assert show_live
             |> form("#weapon-form", weapon: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#weapon-form", weapon: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.weapon_show_path(conn, :show, weapon))

      assert html =~ "Weapon updated successfully"
    end
  end
end
