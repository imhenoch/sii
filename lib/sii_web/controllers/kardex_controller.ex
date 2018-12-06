defmodule SiiWeb.KardexController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Kardex

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    kardexes = Education.list_kardexes()
    render(conn, "index.json", kardexes: kardexes)
  end

  def create_json(conn, %{"kardex" => kardex_params}) do
    with {:ok, %Kardex{} = kardex} <- Education.create_kardex(kardex_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.kardex_path(conn, :show, kardex))
      |> render("show.json", kardex: kardex)
    end
  end

  def show_json(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)
    render(conn, "show.json", kardex: kardex)
  end

  def update_json(conn, %{"id" => id, "kardex" => kardex_params}) do
    kardex = Education.get_kardex!(id)

    with {:ok, %Kardex{} = kardex} <- Education.update_kardex(kardex, kardex_params) do
      render(conn, "show.json", kardex: kardex)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)

    with {:ok, %Kardex{}} <- Education.delete_kardex(kardex) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    kardexes = Education.list_kardexes()
    render(conn, "index.html", kardexes: kardexes)
  end

  def new(conn, _params) do
    changeset = Education.change_kardex(%Kardex{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kardex" => kardex_params}) do
    case Education.create_kardex(kardex_params) do
      {:ok, kardex} ->
        conn
        |> put_flash(:info, "Kardex created successfully.")
        |> redirect(to: Routes.kardex_path(conn, :show, kardex))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)
    render(conn, "show.html", kardex: kardex)
  end

  def edit(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)
    changeset = Education.change_kardex(kardex)
    render(conn, "edit.html", kardex: kardex, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kardex" => kardex_params}) do
    kardex = Education.get_kardex!(id)

    case Education.update_kardex(kardex, kardex_params) do
      {:ok, kardex} ->
        conn
        |> put_flash(:info, "Kardex updated successfully.")
        |> redirect(to: Routes.kardex_path(conn, :show, kardex))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", kardex: kardex, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)
    {:ok, _kardex} = Education.delete_kardex(kardex)

    conn
    |> put_flash(:info, "Kardex deleted successfully.")
    |> redirect(to: Routes.kardex_path(conn, :index))
  end
end
