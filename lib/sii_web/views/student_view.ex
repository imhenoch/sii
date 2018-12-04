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
    %{
      id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email,
      control_number: student.control_number,
      image: student.image,
      career_id: student.career_id,
      semester: student.semester
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("subjects.json", %{subjects: subjects}) do
    subjects |> Enum.map(fn x -> render("subject.json", subject: x) end)
  end

  def render("subject.json", %{subject: subject}) do
    %{
      group_id: subject.group_id,
      subject_name: subject.subject_name,
      teacher_email: subject.teacher_email,
      teacher_first_name: subject.teacher_first_name,
      teacher_last_name: subject.teacher_last_name,
      first_evaluation: subject.first_evaluation,
      second_evaluation: subject.second_evaluation,
      third_evaluation: subject.third_evaluation,
      fourth_evaluation: subject.fourth_evaluation
    }
  end

  def render("kardexes.json", %{kardexes: kardexes}) do
    kardexes |> Enum.map(fn x -> render("kardex.json", kardex: x) end)
  end

  def render("kardex.json", %{kardex: kardex}) do
    %{
      subject_name: kardex.subject_name,
      grade: kardex.grade,
      chance_description: kardex.chance_description
    }
  end

  def render("schedules.json", %{schedules: schedules}) do
    schedules |> Enum.map(fn x -> render("schedule.json", schedule: x) end)
  end

  def render("schedule.json", %{schedule: schedule}) do
    %{
      id: schedule.id,
      subject_name: schedule.subject_name,
      letter: schedule.letter,
      day: schedule.day,
      start_time: schedule.start_time,
      end_time: schedule.end_time,
      classroom: schedule.classroom
    }
  end

  def render("groups.json", %{groups: groups}) do
    groups |> Enum.map(fn x -> render("group.json", group: x) end)
  end

  def render("group.json", %{group: group}) do
    %{
      id: group.id,
      subject_name: group.subject_name,
      letter: group.letter
    }
  end
end
