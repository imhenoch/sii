defmodule SiiWeb.DepartmentController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Department

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    departments = Education.list_departments()
    render(conn, "index.json", departments: departments)
  end

  def create(conn, %{"department" => department_params}) do
    with {:ok, %Department{} = department} <- Education.create_department(department_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.department_path(conn, :show, department))
      |> render("show.json", department: department)
    end
  end

  def show(conn, %{"id" => id}) do
    department = Education.get_department!(id)
    render(conn, "show.json", department: department)
  end

  def update(conn, %{"id" => id, "department" => department_params}) do
    department = Education.get_department!(id)

    with {:ok, %Department{} = department} <- Education.update_department(department, department_params) do
      render(conn, "show.json", department: department)
    end
  end

  def delete(conn, %{"id" => id}) do
    department = Education.get_department!(id)

    with {:ok, %Department{}} <- Education.delete_department(department) do
      send_resp(conn, :no_content, "")
    end
  end
end
