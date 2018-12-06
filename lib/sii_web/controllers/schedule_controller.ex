defmodule SiiWeb.ScheduleController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Schedule

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    schedules = Education.list_schedules()
    render(conn, "index.json", schedules: schedules)
  end

  def create_json(conn, %{"schedule" => schedule_params}) do
    with {:ok, %Schedule{} = schedule} <- Education.create_schedule(schedule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.schedule_path(conn, :show, schedule))
      |> render("show.json", schedule: schedule)
    end
  end

  def show_json(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)
    render(conn, "show.json", schedule: schedule)
  end

  def update_json(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Education.get_schedule!(id)

    with {:ok, %Schedule{} = schedule} <- Education.update_schedule(schedule, schedule_params) do
      render(conn, "show.json", schedule: schedule)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)

    with {:ok, %Schedule{}} <- Education.delete_schedule(schedule) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    schedules = Education.list_schedules()
    render(conn, "index.html", schedules: schedules)
  end

  def new(conn, _params) do
    changeset = Education.change_schedule(%Schedule{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"schedule" => schedule_params}) do
    case Education.create_schedule(schedule_params) do
      {:ok, schedule} ->
        conn
        |> put_flash(:info, "Schedule created successfully.")
        |> redirect(to: Routes.schedule_path(conn, :show, schedule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)
    render(conn, "show.html", schedule: schedule)
  end

  def edit(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)
    changeset = Education.change_schedule(schedule)
    render(conn, "edit.html", schedule: schedule, changeset: changeset)
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Education.get_schedule!(id)

    case Education.update_schedule(schedule, schedule_params) do
      {:ok, schedule} ->
        conn
        |> put_flash(:info, "Schedule updated successfully.")
        |> redirect(to: Routes.schedule_path(conn, :show, schedule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", schedule: schedule, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)
    {:ok, _schedule} = Education.delete_schedule(schedule)

    conn
    |> put_flash(:info, "Schedule deleted successfully.")
    |> redirect(to: Routes.schedule_path(conn, :index))
  end
end
