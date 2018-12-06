defmodule SiiWeb.ChanceController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Chance

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    chances = Education.list_chances()
    render(conn, "index.json", chances: chances)
  end

  def create_json(conn, %{"chance" => chance_params}) do
    with {:ok, %Chance{} = chance} <- Education.create_chance(chance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.chance_path(conn, :show, chance))
      |> render("show.json", chance: chance)
    end
  end

  def show_json(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)
    render(conn, "show.json", chance: chance)
  end

  def update_json(conn, %{"id" => id, "chance" => chance_params}) do
    chance = Education.get_chance!(id)

    with {:ok, %Chance{} = chance} <- Education.update_chance(chance, chance_params) do
      render(conn, "show.json", chance: chance)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)

    with {:ok, %Chance{}} <- Education.delete_chance(chance) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    chances = Education.list_chances()
    render(conn, "index.html", chances: chances)
  end

  def new(conn, _params) do
    changeset = Education.change_chance(%Chance{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chance" => chance_params}) do
    case Education.create_chance(chance_params) do
      {:ok, chance} ->
        conn
        |> put_flash(:info, "Chance created successfully.")
        |> redirect(to: Routes.chance_path(conn, :show, chance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)
    render(conn, "show.html", chance: chance)
  end

  def edit(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)
    changeset = Education.change_chance(chance)
    render(conn, "edit.html", chance: chance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chance" => chance_params}) do
    chance = Education.get_chance!(id)

    case Education.update_chance(chance, chance_params) do
      {:ok, chance} ->
        conn
        |> put_flash(:info, "Chance updated successfully.")
        |> redirect(to: Routes.chance_path(conn, :show, chance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", chance: chance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chance = Education.get_chance!(id)
    {:ok, _chance} = Education.delete_chance(chance)

    conn
    |> put_flash(:info, "Chance deleted successfully.")
    |> redirect(to: Routes.chance_path(conn, :index))
  end
end
