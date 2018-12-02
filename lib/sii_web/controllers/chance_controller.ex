defmodule SiiWeb.ChanceController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Chance

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    chances = Education.list_chances()
    render(conn, "index.json", chances: chances)
  end

  def create(conn, %{"chance" => chance_params}) do
    with {:ok, %Chance{} = chance} <- Education.create_chance(chance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.chance_path(conn, :show, chance))
      |> render("show.json", chance: chance)
    end
  end

  def show(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)
    render(conn, "show.json", chance: chance)
  end

  def update(conn, %{"id" => id, "chance" => chance_params}) do
    chance = Education.get_chance!(id)

    with {:ok, %Chance{} = chance} <- Education.update_chance(chance, chance_params) do
      render(conn, "show.json", chance: chance)
    end
  end

  def delete(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)

    with {:ok, %Chance{}} <- Education.delete_chance(chance) do
      send_resp(conn, :no_content, "")
    end
  end
end
