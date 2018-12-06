defmodule SiiWeb.GroupController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Group

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    groups = Education.list_groups()
    render(conn, "index.json", groups: groups)
  end

  def create_json(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Education.create_group(group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show_json(conn, %{"id" => id}) do
    group = Education.get_group!(id)
    render(conn, "show.json", group: group)
  end

  def update_json(conn, %{"id" => id, "group" => group_params}) do
    group = Education.get_group!(id)

    with {:ok, %Group{} = group} <- Education.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    group = Education.get_group!(id)

    with {:ok, %Group{}} <- Education.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    groups = Education.list_groups()
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
    changeset = Education.change_group(%Group{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    case Education.create_group(group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: Routes.group_path(conn, :show, group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Education.get_group!(id)
    render(conn, "show.html", group: group)
  end

  def edit(conn, %{"id" => id}) do
    group = Education.get_group!(id)
    changeset = Education.change_group(group)
    render(conn, "edit.html", group: group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Education.get_group!(id)

    case Education.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: Routes.group_path(conn, :show, group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Education.get_group!(id)
    {:ok, _group} = Education.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: Routes.group_path(conn, :index))
  end
end
