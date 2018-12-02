defmodule SiiWeb.KardexControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Education
  alias Sii.Education.Kardex

  @create_attrs %{
    grade: 42
  }
  @update_attrs %{
    grade: 43
  }
  @invalid_attrs %{grade: nil}

  def fixture(:kardex) do
    {:ok, kardex} = Education.create_kardex(@create_attrs)
    kardex
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all kardexes", %{conn: conn} do
      conn = get(conn, Routes.kardex_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create kardex" do
    test "renders kardex when data is valid", %{conn: conn} do
      conn = post(conn, Routes.kardex_path(conn, :create), kardex: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.kardex_path(conn, :show, id))

      assert %{
               "id" => id,
               "grade" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.kardex_path(conn, :create), kardex: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update kardex" do
    setup [:create_kardex]

    test "renders kardex when data is valid", %{conn: conn, kardex: %Kardex{id: id} = kardex} do
      conn = put(conn, Routes.kardex_path(conn, :update, kardex), kardex: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.kardex_path(conn, :show, id))

      assert %{
               "id" => id,
               "grade" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, kardex: kardex} do
      conn = put(conn, Routes.kardex_path(conn, :update, kardex), kardex: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete kardex" do
    setup [:create_kardex]

    test "deletes chosen kardex", %{conn: conn, kardex: kardex} do
      conn = delete(conn, Routes.kardex_path(conn, :delete, kardex))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.kardex_path(conn, :show, kardex))
      end
    end
  end

  defp create_kardex(_) do
    kardex = fixture(:kardex)
    {:ok, kardex: kardex}
  end
end
