defmodule SiiWeb.AdminController do
  use SiiWeb, :controller

  alias Sii.Users
  alias Sii.Users.Admin

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    admins = Users.list_admins()
    render(conn, "index.json", admins: admins)
  end

  def create(conn, %{"admin" => admin_params}) do
    with {:ok, %Admin{} = admin} <- Users.create_admin(admin_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.admin_path(conn, :show, admin))
      |> render("show.json", admin: admin)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)
    render(conn, "show.json", admin: admin)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Users.get_admin!(id)

    with {:ok, %Admin{} = admin} <- Users.update_admin(admin, admin_params) do
      render(conn, "show.json", admin: admin)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)

    with {:ok, %Admin{}} <- Users.delete_admin(admin) do
      send_resp(conn, :no_content, "")
    end
  end
end
