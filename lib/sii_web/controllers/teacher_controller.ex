defmodule SiiWeb.TeacherController do
  use SiiWeb, :controller

  alias Sii.Users
  alias Sii.Users.Teacher

  action_fallback SiiWeb.FallbackController

  def sign_in(conn, %{"control_number" => control_number, "password" => password}) do
    case Users.teacher_sign_in(control_number, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def profile(conn, _params) do
    teacher = Guardian.Plug.current_resource(conn)
    conn |> render("show.json", teacher: teacher)
  end

  def update_teacher_profile(conn, %{"teacher" => teacher_params}) do
    teacher = Guardian.Plug.current_resource(conn)

    with {:ok, %Teacher{} = teacher} <- Users.update_teacher_profile(teacher, teacher_params) do
      conn |> render("show.json", teacher: teacher)
    end
  end

  def teacher_groups(conn, _params) do
    teacher = Guardian.Plug.current_resource(conn)

    groups = Users.list_teacher_groups(teacher.id)
    conn |> render("groups.json", groups: groups)
  end

  def group_list(conn, %{"group_id" => group_id}) do
    students = Users.list_group_students(group_id)
    conn |> render("students.json", students: students)
  end

  def index_json(conn, _params) do
    teachers = Users.list_teachers()
    render(conn, "index.json", teachers: teachers)
  end

  def create_json(conn, %{"teacher" => teacher_params}) do
    with {:ok, %Teacher{} = teacher} <- Users.create_teacher(teacher_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.teacher_path(conn, :show, teacher))
      |> render("show.json", teacher: teacher)
    end
  end

  def show_json(conn, %{"id" => id}) do
    teacher = Users.get_teacher!(id)
    render(conn, "show.json", teacher: teacher)
  end

  def update_json(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Users.get_teacher!(id)

    with {:ok, %Teacher{} = teacher} <- Users.update_teacher(teacher, teacher_params) do
      render(conn, "show.json", teacher: teacher)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    teacher = Users.get_teacher!(id)

    with {:ok, %Teacher{}} <- Users.delete_teacher(teacher) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    teachers = Users.list_teachers()
    render(conn, "index.html", teachers: teachers)
  end

  def new(conn, _params) do
    changeset = Users.change_teacher(%Teacher{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    case Users.create_teacher(teacher_params) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher created successfully.")
        |> redirect(to: Routes.teacher_path(conn, :show, teacher))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = Users.get_teacher!(id)
    render(conn, "show.html", teacher: teacher)
  end

  def edit(conn, %{"id" => id}) do
    teacher = Users.get_teacher!(id)
    changeset = Users.change_teacher(teacher)
    render(conn, "edit.html", teacher: teacher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Users.get_teacher!(id)

    case Users.update_teacher(teacher, teacher_params) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher updated successfully.")
        |> redirect(to: Routes.teacher_path(conn, :show, teacher))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", teacher: teacher, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Users.get_teacher!(id)
    {:ok, _teacher} = Users.delete_teacher(teacher)

    conn
    |> put_flash(:info, "teacher deleted successfully.")
    |> redirect(to: Routes.teacher_path(conn, :index))
  end
end
