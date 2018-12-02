defmodule SiiWeb.ScheduleController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Schedule

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    schedules = Education.list_schedules()
    render(conn, "index.json", schedules: schedules)
  end

  def create(conn, %{"schedule" => schedule_params}) do
    with {:ok, %Schedule{} = schedule} <- Education.create_schedule(schedule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.schedule_path(conn, :show, schedule))
      |> render("show.json", schedule: schedule)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)
    render(conn, "show.json", schedule: schedule)
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Education.get_schedule!(id)

    with {:ok, %Schedule{} = schedule} <- Education.update_schedule(schedule, schedule_params) do
      render(conn, "show.json", schedule: schedule)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Education.get_schedule!(id)

    with {:ok, %Schedule{}} <- Education.delete_schedule(schedule) do
      send_resp(conn, :no_content, "")
    end
  end
end
