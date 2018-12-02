defmodule SiiWeb.CareerControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Education
  alias Sii.Education.Career

  @create_attrs %{
    career_name: "some career_name"
  }
  @update_attrs %{
    career_name: "some updated career_name"
  }
  @invalid_attrs %{career_name: nil}

  def fixture(:career) do
    {:ok, career} = Education.create_career(@create_attrs)
    career
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all careers", %{conn: conn} do
      conn = get(conn, Routes.career_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create career" do
    test "renders career when data is valid", %{conn: conn} do
      conn = post(conn, Routes.career_path(conn, :create), career: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.career_path(conn, :show, id))

      assert %{
               "id" => id,
               "career_name" => "some career_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.career_path(conn, :create), career: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update career" do
    setup [:create_career]

    test "renders career when data is valid", %{conn: conn, career: %Career{id: id} = career} do
      conn = put(conn, Routes.career_path(conn, :update, career), career: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.career_path(conn, :show, id))

      assert %{
               "id" => id,
               "career_name" => "some updated career_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, career: career} do
      conn = put(conn, Routes.career_path(conn, :update, career), career: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete career" do
    setup [:create_career]

    test "deletes chosen career", %{conn: conn, career: career} do
      conn = delete(conn, Routes.career_path(conn, :delete, career))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.career_path(conn, :show, career))
      end
    end
  end

  defp create_career(_) do
    career = fixture(:career)
    {:ok, career: career}
  end
end
