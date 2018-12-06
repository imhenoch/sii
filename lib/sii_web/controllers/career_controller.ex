defmodule SiiWeb.CareerController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Career

  def index_json(conn, _params) do
    careers = Education.list_careers()
    render(conn, "index.json", careers: careers)
  end

  def create_json(conn, %{"career" => career_params}) do
    with {:ok, %Career{} = career} <- Education.create_career(career_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.career_path(conn, :show, career))
      |> render("show.json", career: career)
    end
  end

  def show_json(conn, %{"id" => id}) do
    career = Education.get_career!(id)
    render(conn, "show.json", career: career)
  end

  def update_json(conn, %{"id" => id, "career" => career_params}) do
    career = Education.get_career!(id)

    with {:ok, %Career{} = career} <- Education.update_career(career, career_params) do
      render(conn, "show.json", career: career)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    career = Education.get_career!(id)

    with {:ok, %Career{}} <- Education.delete_career(career) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    careers = Education.list_careers()
    render(conn, "index.html", careers: careers)
  end

  def new(conn, _params) do
    changeset = Education.change_career(%Career{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"career" => career_params}) do
    case Education.create_career(career_params) do
      {:ok, career} ->
        conn
        |> put_flash(:info, "Career created successfully.")
        |> redirect(to: Routes.career_path(conn, :show, career))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    career = Education.get_career!(id)
    render(conn, "show.html", career: career)
  end

  def edit(conn, %{"id" => id}) do
    career = Education.get_career!(id)
    changeset = Education.change_career(career)
    render(conn, "edit.html", career: career, changeset: changeset)
  end

  def update(conn, %{"id" => id, "career" => career_params}) do
    career = Education.get_career!(id)

    case Education.update_career(career, career_params) do
      {:ok, career} ->
        conn
        |> put_flash(:info, "Career updated successfully.")
        |> redirect(to: Routes.career_path(conn, :show, career))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", career: career, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    career = Education.get_career!(id)
    {:ok, _career} = Education.delete_career(career)

    conn
    |> put_flash(:info, "Career deleted successfully.")
    |> redirect(to: Routes.career_path(conn, :index))
  end
end
