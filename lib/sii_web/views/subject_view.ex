defmodule SiiWeb.SubjectView do
  use SiiWeb, :view
  alias SiiWeb.SubjectView

  def render("index.json", %{subjects: subjects}) do
    render_many(subjects, SubjectView, "subject.json")
  end

  def render("show.json", %{subject: subject}) do
    render_one(subject, SubjectView, "subject.json")
  end

  def render("subject.json", %{subject: subject}) do
    %{id: subject.id, subject_name: subject.subject_name}
  end
end
