defmodule SiiWeb.ListController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.List

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    lists = Education.list_lists()
    render(conn, "index.json", lists: lists)
  end

  def create(conn, %{"list" => list_params}) do
    with {:ok, %List{} = list} <- Education.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Education.get_list!(id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Education.get_list!(id)

    with {:ok, %List{} = list} <- Education.update_list(list, list_params) do
      render(conn, "show.json", list: list)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Education.get_list!(id)

    with {:ok, %List{}} <- Education.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
