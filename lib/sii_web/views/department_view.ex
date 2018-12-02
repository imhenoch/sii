defmodule SiiWeb.DepartmentView do
  use SiiWeb, :view
  alias SiiWeb.DepartmentView

  def render("index.json", %{departments: departments}) do
    render_many(departments, DepartmentView, "department.json")
  end

  def render("show.json", %{department: department}) do
    render_one(department, DepartmentView, "department.json")
  end

  def render("department.json", %{department: department}) do
    %{id: department.id, department_name: department.department_name}
  end
end
