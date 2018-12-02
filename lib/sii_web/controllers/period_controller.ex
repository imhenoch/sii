defmodule SiiWeb.PeriodController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Period

  action_fallback SiiWeb.FallbackController

  def index(conn, _params) do
    periods = Education.list_periods()
    render(conn, "index.json", periods: periods)
  end

  def create(conn, %{"period" => period_params}) do
    with {:ok, %Period{} = period} <- Education.create_period(period_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.period_path(conn, :show, period))
      |> render("show.json", period: period)
    end
  end

  def show(conn, %{"id" => id}) do
    period = Education.get_period!(id)
    render(conn, "show.json", period: period)
  end

  def update(conn, %{"id" => id, "period" => period_params}) do
    period = Education.get_period!(id)

    with {:ok, %Period{} = period} <- Education.update_period(period, period_params) do
      render(conn, "show.json", period: period)
    end
  end

  def delete(conn, %{"id" => id}) do
    period = Education.get_period!(id)

    with {:ok, %Period{}} <- Education.delete_period(period) do
      send_resp(conn, :no_content, "")
    end
  end
end
