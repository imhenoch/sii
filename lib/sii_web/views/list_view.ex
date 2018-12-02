defmodule SiiWeb.ListView do
  use SiiWeb, :view
  alias SiiWeb.ListView

  def render("index.json", %{lists: lists}) do
    render_many(lists, ListView, "list.json")
  end

  def render("show.json", %{list: list}) do
    render_one(list, ListView, "list.json")
  end

  def render("list.json", %{list: list}) do
    %{
      id: list.id,
      first_evaluation: list.first_evaluation,
      second_evaluation: list.second_evaluation,
      third_evaluation: list.third_evaluation,
      fourth_evaluation: list.fourth_evaluation
    }
  end
end
