defmodule SiiWeb.SubjectController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Subject

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    subjects = Education.list_subjects()
    render(conn, "index.json", subjects: subjects)
  end

  def create_json(conn, %{"subject" => subject_params}) do
    with {:ok, %Subject{} = subject} <- Education.create_subject(subject_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.subject_path(conn, :show, subject))
      |> render("show.json", subject: subject)
    end
  end

  def show_json(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)
    render(conn, "show.json", subject: subject)
  end

  def update_json(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Education.get_subject!(id)

    with {:ok, %Subject{} = subject} <- Education.update_subject(subject, subject_params) do
      render(conn, "show.json", subject: subject)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)

    with {:ok, %Subject{}} <- Education.delete_subject(subject) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    subjects = Education.list_subjects()
    render(conn, "index.html", subjects: subjects)
  end

  def new(conn, _params) do
    changeset = Education.change_subject(%Subject{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subject" => subject_params}) do
    case Education.create_subject(subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject created successfully.")
        |> redirect(to: Routes.subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)
    render(conn, "show.html", subject: subject)
  end

  def edit(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)
    changeset = Education.change_subject(subject)
    render(conn, "edit.html", subject: subject, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Education.get_subject!(id)

    case Education.update_subject(subject, subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject updated successfully.")
        |> redirect(to: Routes.subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subject: subject, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = Education.get_subject!(id)
    {:ok, _subject} = Education.delete_subject(subject)

    conn
    |> put_flash(:info, "Subject deleted successfully.")
    |> redirect(to: Routes.subject_path(conn, :index))
  end
end
