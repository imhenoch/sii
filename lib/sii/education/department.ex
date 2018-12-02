defmodule Sii.Education.Department do
  use Ecto.Schema
  import Ecto.Changeset


  schema "departments" do
    field :department_name, :string

    timestamps()
  end

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, [:department_name])
    |> validate_required([:department_name])
    |> unique_constraint(:department_name)
  end
end
