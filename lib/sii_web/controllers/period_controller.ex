defmodule SiiWeb.PeriodController do
  use SiiWeb, :controller

  alias Sii.Education
  alias Sii.Education.Period

  action_fallback SiiWeb.FallbackController

  def index_json(conn, _params) do
    periods = Education.list_periods()
    render(conn, "index.json", periods: periods)
  end

  def create_json(conn, %{"period" => period_params}) do
    with {:ok, %Period{} = period} <- Education.create_period(period_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.period_path(conn, :show, period))
      |> render("show.json", period: period)
    end
  end

  def show_json(conn, %{"id" => id}) do
    period = Education.get_period!(id)
    render(conn, "show.json", period: period)
  end

  def update_json(conn, %{"id" => id, "period" => period_params}) do
    period = Education.get_period!(id)

    with {:ok, %Period{} = period} <- Education.update_period(period, period_params) do
      render(conn, "show.json", period: period)
    end
  end

  def delete_json(conn, %{"id" => id}) do
    period = Education.get_period!(id)

    with {:ok, %Period{}} <- Education.delete_period(period) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    periods = Education.list_periods()
    render(conn, "index.html", periods: periods)
  end

  def new(conn, _params) do
    changeset = Education.change_period(%Period{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"period" => period_params}) do
    case Education.create_period(period_params) do
      {:ok, period} ->
        conn
        |> put_flash(:info, "Period created successfully.")
        |> redirect(to: Routes.period_path(conn, :show, period))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    period = Education.get_period!(id)
    render(conn, "show.html", period: period)
  end

  def edit(conn, %{"id" => id}) do
    period = Education.get_period!(id)
    changeset = Education.change_period(period)
    render(conn, "edit.html", period: period, changeset: changeset)
  end

  def update(conn, %{"id" => id, "period" => period_params}) do
    period = Education.get_period!(id)

    case Education.update_period(period, period_params) do
      {:ok, period} ->
        conn
        |> put_flash(:info, "Period updated successfully.")
        |> redirect(to: Routes.period_path(conn, :show, period))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", period: period, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    period = Education.get_period!(id)
    {:ok, _period} = Education.delete_period(period)

    conn
    |> put_flash(:info, "Period deleted successfully.")
    |> redirect(to: Routes.period_path(conn, :index))
  end
end
