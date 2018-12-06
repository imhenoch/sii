defmodule SiiWeb.AdminController do
  use SiiWeb, :controller

  alias Sii.Users
  alias Sii.Users.Admin

  action_fallback SiiWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Users.admin_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def index_json(conn, _params) do
    admins = Users.list_admins()
    render(conn, "index.json", admins: admins)
  end

  def create_json(conn, %{"admin" => admin_params}) do
    with {:ok, %Admin{} = admin} <- Users.create_admin(admin_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.admin_path(conn, :show, admin))
      |> render("show.json", admin: admin)
    end
  end

  def show_json(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)
    render(conn, "show.json", admin: admin)
  end

  def update_json(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Users.get_admin!(id)

    with {:ok, %Admin{} = admin} <- Users.update_admin(admin, admin_params) do
      render(conn, "show.json", admin: admin)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)

    with {:ok, %Admin{}} <- Users.delete_admin(admin) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    admins = Users.list_admins()
    render(conn, "index.html", admins: admins)
  end

  def new(conn, _params) do
    changeset = Users.change_admin(%Admin{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"admin" => admin_params}) do
    case Users.create_admin(admin_params) do
      {:ok, admin} ->
        conn
        |> put_flash(:info, "Admin created successfully.")
        |> redirect(to: Routes.admin_path(conn, :show, admin))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)
    render(conn, "show.html", admin: admin)
  end

  def edit(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)
    changeset = Users.change_admin(admin)
    render(conn, "edit.html", admin: admin, changeset: changeset)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Users.get_admin!(id)

    case Users.update_admin(admin, admin_params) do
      {:ok, admin} ->
        conn
        |> put_flash(:info, "Admin updated successfully.")
        |> redirect(to: Routes.admin_path(conn, :show, admin))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", admin: admin, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Users.get_admin!(id)
    {:ok, _admin} = Users.delete_admin(admin)

    conn
    |> put_flash(:info, "Admin deleted successfully.")
    |> redirect(to: Routes.admin_path(conn, :index))
  end
end
