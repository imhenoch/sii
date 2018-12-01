defmodule SiiWeb.CareerView do
  use SiiWeb, :view
  alias SiiWeb.CareerView

  def render("index.json", %{careers: careers}) do
    render_many(careers, CareerView, "career.json")
  end

  def render("show.json", %{career: career}) do
    render_one(career, CareerView, "career.json")
  end

  def render("career.json", %{career: career}) do
    %{id: career.id, career_name: career.career_name}
  end
end
