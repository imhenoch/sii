defmodule SiiWeb.ScheduleView do
  use SiiWeb, :view
  alias SiiWeb.ScheduleView

  def render("index.json", %{schedules: schedules}) do
    render_many(schedules, ScheduleView, "schedule.json")
  end

  def render("show.json", %{schedule: schedule}) do
    render_one(schedule, ScheduleView, "schedule.json")
  end

  def render("schedule.json", %{schedule: schedule}) do
    %{
      id: schedule.id,
      day: schedule.day,
      start_time: schedule.start_time,
      end_time: schedule.end_time,
      classroom: schedule.classroom
    }
  end
end
