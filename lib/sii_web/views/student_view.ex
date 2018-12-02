defmodule SiiWeb.StudentView do
  use SiiWeb, :view
  alias SiiWeb.StudentView

  def render("index.json", %{students: students}) do
    render_many(students, StudentView, "student.json")
  end

  def render("show.json", %{student: student}) do
    render_one(student, StudentView, "student.json")
  end

  def render("student.json", %{student: student}) do
    %{id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email,
      control_number: student.control_number,
      password_hash: student.password_hash,
      image: student.image}
  end
end
