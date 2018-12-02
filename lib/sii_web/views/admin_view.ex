defmodule SiiWeb.AdminView do
  use SiiWeb, :view
  alias SiiWeb.AdminView

  def render("index.json", %{admins: admins}) do
    render_many(admins, AdminView, "admin.json")
  end

  def render("show.json", %{admin: admin}) do
    render_one(admin, AdminView, "admin.json")
  end

  def render("admin.json", %{admin: admin}) do
    %{id: admin.id, email: admin.email}
  end
end
