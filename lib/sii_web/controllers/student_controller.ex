defmodule SiiWeb.StudentController do
  use SiiWeb, :controller

  alias Sii.Users
  alias Sii.Users.Student

  action_fallback SiiWeb.FallbackController

  def sign_in(conn, %{"control_number" => control_number, "password" => password}) do
    case Users.student_sign_in(control_number, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def profile(conn, _params) do
    student = Guardian.Plug.current_resource(conn)
    conn |> render("show.json", student: student)
  end

  def update_profile(conn, %{"student" => student_params}) do
    student = Guardian.Plug.current_resource(conn)

    with {:ok, %Student{} = student} <- Users.update_profile(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def student_subjects(conn, _params) do
    student = Guardian.Plug.current_resource(conn)
    subjects = Users.list_student_subjects(student.id)
    conn |> render("subjects.json", subjects: subjects)
  end

  def student_kardex(conn, _params) do
    student = Guardian.Plug.current_resource(conn)
    kardexes = Users.list_student_kardex(student.id)
    conn |> render("kardexes.json", kardexes: kardexes)
  end

  def student_schedule(conn, _params) do
    student = Guardian.Plug.current_resource(conn)
    schedules = Users.list_student_shcedule(student.id)
    conn |> render("schedules.json", schedules: schedules)
  end

  def index(conn, _params) do
    students = Users.list_students()
    render(conn, "index.json", students: students)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Users.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Users.get_student!(id)
    render(conn, "show.json", student: student)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Users.get_student!(id)

    with {:ok, %Student{} = student} <- Users.update_student(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Users.get_student!(id)

    with {:ok, %Student{}} <- Users.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end
end
