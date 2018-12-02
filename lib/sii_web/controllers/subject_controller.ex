defmodule SiiWeb.SubjectController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Subject

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    subjects = Education.list_subjects()
    render(conn, "index.json", subjects: subjects)
  end

  def create(conn, %{"subject" => subject_params}) do
    with {:ok, %Subject{} = subject} <- Education.create_subject(subject_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.subject_path(conn, :show, subject))
      |> render("show.json", subject: subject)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)
    render(conn, "show.json", subject: subject)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Education.get_subject!(id)

    with {:ok, %Subject{} = subject} <- Education.update_subject(subject, subject_params) do
      render(conn, "show.json", subject: subject)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)

    with {:ok, %Subject{}} <- Education.delete_subject(subject) do
      send_resp(conn, :no_content, "")
    end
  end
end
