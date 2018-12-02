defmodule SiiWeb.KardexController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Kardex

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    kardexes = Education.list_kardexes()
    render(conn, "index.json", kardexes: kardexes)
  end

  def create(conn, %{"kardex" => kardex_params}) do
    with {:ok, %Kardex{} = kardex} <- Education.create_kardex(kardex_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.kardex_path(conn, :show, kardex))
      |> render("show.json", kardex: kardex)
    end
  end

  def show(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)
    render(conn, "show.json", kardex: kardex)
  end

  def update(conn, %{"id" => id, "kardex" => kardex_params}) do
    kardex = Education.get_kardex!(id)

    with {:ok, %Kardex{} = kardex} <- Education.update_kardex(kardex, kardex_params) do
      render(conn, "show.json", kardex: kardex)
    end
  end

  def delete(conn, %{"id" => id}) do
    kardex = Education.get_kardex!(id)

    with {:ok, %Kardex{}} <- Education.delete_kardex(kardex) do
      send_resp(conn, :no_content, "")
    end
  end
end
