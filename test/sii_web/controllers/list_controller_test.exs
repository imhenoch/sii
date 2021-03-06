defmodule SiiWeb.ListControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Education
  alias Sii.Education.List

  @create_attrs %{
    first_evaluation: 42,
    fourth_evaluation: 42,
    second_evaluation: 42,
    third_evaluation: 42
  }
  @update_attrs %{
    first_evaluation: 43,
    fourth_evaluation: 43,
    second_evaluation: 43,
    third_evaluation: 43
  }
  @invalid_attrs %{first_evaluation: nil, fourth_evaluation: nil, second_evaluation: nil, third_evaluation: nil}

  def fixture(:list) do
    {:ok, list} = Education.create_list(@create_attrs)
    list
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lists", %{conn: conn} do
      conn = get(conn, Routes.list_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create list" do
    test "renders list when data is valid", %{conn: conn} do
      conn = post(conn, Routes.list_path(conn, :create), list: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.list_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_evaluation" => 42,
               "fourth_evaluation" => 42,
               "second_evaluation" => 42,
               "third_evaluation" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.list_path(conn, :create), list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update list" do
    setup [:create_list]

    test "renders list when data is valid", %{conn: conn, list: %List{id: id} = list} do
      conn = put(conn, Routes.list_path(conn, :update, list), list: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.list_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_evaluation" => 43,
               "fourth_evaluation" => 43,
               "second_evaluation" => 43,
               "third_evaluation" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, list: list} do
      conn = put(conn, Routes.list_path(conn, :update, list), list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete list" do
    setup [:create_list]

    test "deletes chosen list", %{conn: conn, list: list} do
      conn = delete(conn, Routes.list_path(conn, :delete, list))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.list_path(conn, :show, list))
      end
    end
  end

  defp create_list(_) do
    list = fixture(:list)
    {:ok, list: list}
  end
end
