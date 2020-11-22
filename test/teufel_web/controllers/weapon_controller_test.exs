defmodule TeufelWeb.WeaponControllerTest do
  use TeufelWeb.ConnCase

  alias Teufel.Item

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:weapon) do
    {:ok, weapon} = Item.create_weapon(@create_attrs)
    weapon
  end

  describe "index" do
    test "lists all weapons", %{conn: conn} do
      conn = get(conn, Routes.weapon_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Weapons"
    end
  end

  describe "new weapon" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.weapon_path(conn, :new))
      assert html_response(conn, 200) =~ "New Weapon"
    end
  end

  describe "create weapon" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.weapon_path(conn, :create), weapon: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.weapon_path(conn, :show, id)

      conn = get(conn, Routes.weapon_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Weapon"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.weapon_path(conn, :create), weapon: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Weapon"
    end
  end

  describe "edit weapon" do
    setup [:create_weapon]

    test "renders form for editing chosen weapon", %{conn: conn, weapon: weapon} do
      conn = get(conn, Routes.weapon_path(conn, :edit, weapon))
      assert html_response(conn, 200) =~ "Edit Weapon"
    end
  end

  describe "update weapon" do
    setup [:create_weapon]

    test "redirects when data is valid", %{conn: conn, weapon: weapon} do
      conn = put(conn, Routes.weapon_path(conn, :update, weapon), weapon: @update_attrs)
      assert redirected_to(conn) == Routes.weapon_path(conn, :show, weapon)

      conn = get(conn, Routes.weapon_path(conn, :show, weapon))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, weapon: weapon} do
      conn = put(conn, Routes.weapon_path(conn, :update, weapon), weapon: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Weapon"
    end
  end

  describe "delete weapon" do
    setup [:create_weapon]

    test "deletes chosen weapon", %{conn: conn, weapon: weapon} do
      conn = delete(conn, Routes.weapon_path(conn, :delete, weapon))
      assert redirected_to(conn) == Routes.weapon_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.weapon_path(conn, :show, weapon))
      end
    end
  end

  defp create_weapon(_) do
    weapon = fixture(:weapon)
    %{weapon: weapon}
  end
end
