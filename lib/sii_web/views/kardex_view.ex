defmodule SiiWeb.KardexView do
  use SiiWeb, :view
  alias SiiWeb.KardexView

  def render("index.json", %{kardexes: kardexes}) do
    render_many(kardexes, KardexView, "kardex.json")
  end

  def render("show.json", %{kardex: kardex}) do
    render_one(kardex, KardexView, "kardex.json")
  end

  def render("kardex.json", %{kardex: kardex}) do
    %{id: kardex.id, grade: kardex.grade}
  end
end
