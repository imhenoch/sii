defmodule SiiWeb.ChanceControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Education
  alias Sii.Education.Chance

  @create_attrs %{
    chance_description: "some chance_description"
  }
  @update_attrs %{
    chance_description: "some updated chance_description"
  }
  @invalid_attrs %{chance_description: nil}

  def fixture(:chance) do
    {:ok, chance} = Education.create_chance(@create_attrs)
    chance
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all chances", %{conn: conn} do
      conn = get(conn, Routes.chance_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create chance" do
    test "renders chance when data is valid", %{conn: conn} do
      conn = post(conn, Routes.chance_path(conn, :create), chance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.chance_path(conn, :show, id))

      assert %{
               "id" => id,
               "chance_description" => "some chance_description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.chance_path(conn, :create), chance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update chance" do
    setup [:create_chance]

    test "renders chance when data is valid", %{conn: conn, chance: %Chance{id: id} = chance} do
      conn = put(conn, Routes.chance_path(conn, :update, chance), chance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.chance_path(conn, :show, id))

      assert %{
               "id" => id,
               "chance_description" => "some updated chance_description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, chance: chance} do
      conn = put(conn, Routes.chance_path(conn, :update, chance), chance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete chance" do
    setup [:create_chance]

    test "deletes chosen chance", %{conn: conn, chance: chance} do
      conn = delete(conn, Routes.chance_path(conn, :delete, chance))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.chance_path(conn, :show, chance))
      end
    end
  end

  defp create_chance(_) do
    chance = fixture(:chance)
    {:ok, chance: chance}
  end
end
