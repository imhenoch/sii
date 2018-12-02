defmodule SiiWeb.TeacherView do
  use SiiWeb, :view
  alias SiiWeb.TeacherView

  def render("index.json", %{teachers: teachers}) do
    render_many(teachers, TeacherView, "teacher.json")
  end

  def render("show.json", %{teacher: teacher}) do
    render_one(teacher, TeacherView, "teacher.json")
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{
      id: teacher.id,
      first_name: teacher.first_name,
      last_name: teacher.last_name,
      email: teacher.email,
      control_number: teacher.control_number,
      department_id: teacher.department_id
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
