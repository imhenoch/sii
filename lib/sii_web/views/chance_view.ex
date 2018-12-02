defmodule SiiWeb.ChanceView do
  use SiiWeb, :view
  alias SiiWeb.ChanceView

  def render("index.json", %{chances: chances}) do
    render_many(chances, ChanceView, "chance.json")
  end

  def render("show.json", %{chance: chance}) do
    render_one(chance, ChanceView, "chance.json")
  end

  def render("chance.json", %{chance: chance}) do
    %{id: chance.id, chance_description: chance.chance_description}
  end
end
