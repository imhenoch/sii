defmodule SiiWeb.GroupView do
  use SiiWeb, :view
  alias SiiWeb.GroupView

  def render("index.json", %{groups: groups}) do
    render_many(groups, GroupView, "group.json")
  end

  def render("show.json", %{group: group}) do
    render_one(group, GroupView, "group.json")
  end

  def render("group.json", %{group: group}) do
    %{
      id: group.id,
      letter: group.letter,
      open: group.open,
      subject_id: group.subject_id,
      teacher_id: group.teacher_id
    }
  end
end
