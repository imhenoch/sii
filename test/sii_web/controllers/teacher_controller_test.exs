defmodule SiiWeb.TeacherControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Users
  alias Sii.Users.Teacher

  @create_attrs %{
    control_number: "some control_number",
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    password_hash: "some password_hash"
  }
  @update_attrs %{
    control_number: "some updated control_number",
    email: "some updated email",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    password_hash: "some updated password_hash"
  }
  @invalid_attrs %{control_number: nil, email: nil, first_name: nil, last_name: nil, password_hash: nil}

  def fixture(:teacher) do
    {:ok, teacher} = Users.create_teacher(@create_attrs)
    teacher
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teachers", %{conn: conn} do
      conn = get(conn, Routes.teacher_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teacher" do
    test "renders teacher when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teacher: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teacher_path(conn, :show, id))

      assert %{
               "id" => id,
               "control_number" => "some control_number",
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "password_hash" => "some password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teacher: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teacher" do
    setup [:create_teacher]

    test "renders teacher when data is valid", %{conn: conn, teacher: %Teacher{id: id} = teacher} do
      conn = put(conn, Routes.teacher_path(conn, :update, teacher), teacher: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.teacher_path(conn, :show, id))

      assert %{
               "id" => id,
               "control_number" => "some updated control_number",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "password_hash" => "some updated password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, teacher: teacher} do
      conn = put(conn, Routes.teacher_path(conn, :update, teacher), teacher: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teacher" do
    setup [:create_teacher]

    test "deletes chosen teacher", %{conn: conn, teacher: teacher} do
      conn = delete(conn, Routes.teacher_path(conn, :delete, teacher))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.teacher_path(conn, :show, teacher))
      end
    end
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    {:ok, teacher: teacher}
  end
end
