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

  def update_student_profile(conn, %{"student" => student_params}) do
    student = Guardian.Plug.current_resource(conn)

    with {:ok, %Student{} = student} <- Users.update_student_profile(student, student_params) do
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

  def available_groups(conn, _params) do
    student = Guardian.Plug.current_resource(conn)
    groups = Users.list_available_groups(student.career_id)
    conn |> render("groups.json", groups: groups)
  end

  def index_json(conn, _params) do
    students = Users.list_students()
    render(conn, "index.json", students: students)
  end

  def create_json(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Users.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show_json(conn, %{"id" => id}) do
    student = Users.get_student!(id)
    render(conn, "show.json", student: student)
  end

  def update_json(conn, %{"id" => id, "student" => student_params}) do
    student = Users.get_student!(id)

    with {:ok, %Student{} = student} <- Users.update_student(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    student = Users.get_student!(id)

    with {:ok, %Student{}} <- Users.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    students = Users.list_students()
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    changeset = Users.change_student(%Student{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    case Users.create_student(student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: Routes.student_path(conn, :show, student))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Users.get_student!(id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Users.get_student!(id)
    changeset = Users.change_student(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Users.get_student!(id)

    case Users.update_student(student, student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: Routes.student_path(conn, :show, student))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Users.get_student!(id)
    {:ok, _student} = Users.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: Routes.student_path(conn, :index))
  end
end
