defmodule SiiWeb.DepartmentController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Department

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    departments = Education.list_departments()
    render(conn, "index.json", departments: departments)
  end

  def create_json(conn, %{"department" => department_params}) do
    with {:ok, %Department{} = department} <- Education.create_department(department_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.department_path(conn, :show, department))
      |> render("show.json", department: department)
    end
  end

  def show_json(conn, %{"id" => id}) do
    department = Education.get_department!(id)
    render(conn, "show.json", department: department)
  end

  def update_json(conn, %{"id" => id, "department" => department_params}) do
    department = Education.get_department!(id)

    with {:ok, %Department{} = department} <-
           Education.update_department(department, department_params) do
      render(conn, "show.json", department: department)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    department = Education.get_department!(id)

    with {:ok, %Department{}} <- Education.delete_department(department) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    departments = Education.list_departments()
    render(conn, "index.html", departments: departments)
  end

  def new(conn, _params) do
    changeset = Education.change_department(%Department{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"department" => department_params}) do
    case Education.create_department(department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department created successfully.")
        |> redirect(to: Routes.department_path(conn, :show, department))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    department = Education.get_department!(id)
    render(conn, "show.html", department: department)
  end

  def edit(conn, %{"id" => id}) do
    department = Education.get_department!(id)
    changeset = Education.change_department(department)
    render(conn, "edit.html", department: department, changeset: changeset)
  end

  def update(conn, %{"id" => id, "department" => department_params}) do
    department = Education.get_department!(id)

    case Education.update_department(department, department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department updated successfully.")
        |> redirect(to: Routes.department_path(conn, :show, department))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", department: department, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    department = Education.get_department!(id)
    {:ok, _department} = Education.delete_department(department)

    conn
    |> put_flash(:info, "Department deleted successfully.")
    |> redirect(to: Routes.department_path(conn, :index))
  end
end
