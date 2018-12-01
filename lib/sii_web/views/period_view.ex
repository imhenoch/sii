defmodule SiiWeb.PeriodView do
  use SiiWeb, :view
  alias SiiWeb.PeriodView

  def render("index.json", %{periods: periods}) do
    render_many(periods, PeriodView, "period.json")
  end

  def render("show.json", %{period: period}) do
    render_one(period, PeriodView, "period.json")
  end

  def render("period.json", %{period: period}) do
    %{id: period.id, year: period.year, part: period.part}
  end
end
