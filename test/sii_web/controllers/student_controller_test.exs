defmodule SiiWeb.StudentControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Users
  alias Sii.Users.Student

  @create_attrs %{
    control_number: "some control_number",
    email: "some email",
    first_name: "some first_name",
    image: "some image",
    last_name: "some last_name",
    password_hash: "some password_hash"
  }
  @update_attrs %{
    control_number: "some updated control_number",
    email: "some updated email",
    first_name: "some updated first_name",
    image: "some updated image",
    last_name: "some updated last_name",
    password_hash: "some updated password_hash"
  }
  @invalid_attrs %{control_number: nil, email: nil, first_name: nil, image: nil, last_name: nil, password_hash: nil}

  def fixture(:student) do
    {:ok, student} = Users.create_student(@create_attrs)
    student
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all students", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create student" do
    test "renders student when data is valid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => id,
               "control_number" => "some control_number",
               "email" => "some email",
               "first_name" => "some first_name",
               "image" => "some image",
               "last_name" => "some last_name",
               "password_hash" => "some password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update student" do
    setup [:create_student]

    test "renders student when data is valid", %{conn: conn, student: %Student{id: id} = student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => id,
               "control_number" => "some updated control_number",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "image" => "some updated image",
               "last_name" => "some updated last_name",
               "password_hash" => "some updated password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, Routes.student_path(conn, :delete, student))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.student_path(conn, :show, student))
      end
    end
  end

  defp create_student(_) do
    student = fixture(:student)
    {:ok, student: student}
  end
end
