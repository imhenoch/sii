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

  def render("groups.json", %{groups: groups}) do
    groups |> Enum.map(fn x -> render("group.json", group: x) end)
  end

  def render("group.json", %{group: group}) do
    %{
      group_id: group.group_id,
      subject_name: group.subject_name,
      letter: group.letter,
      career_name: group.career_name
    }
  end
end
