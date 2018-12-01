defmodule SiiWeb.CareerController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Career

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    careers = Education.list_careers()
    render(conn, "index.json", careers: careers)
  end

  def create(conn, %{"career" => career_params}) do
    with {:ok, %Career{} = career} <- Education.create_career(career_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.career_path(conn, :show, career))
      |> render("show.json", career: career)
    end
  end

  def show(conn, %{"id" => id}) do
    career = Education.get_career!(id)
    render(conn, "show.json", career: career)
  end

  def update(conn, %{"id" => id, "career" => career_params}) do
    career = Education.get_career!(id)

    with {:ok, %Career{} = career} <- Education.update_career(career, career_params) do
      render(conn, "show.json", career: career)
    end
  end

  def delete(conn, %{"id" => id}) do
    career = Education.get_career!(id)

    with {:ok, %Career{}} <- Education.delete_career(career) do
      send_resp(conn, :no_content, "")
    end
  end
end
