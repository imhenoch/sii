defmodule Sii.Education.Career do
  use Ecto.Schema
  import Ecto.Changeset


  schema "careers" do
    field :career_name, :string

    timestamps()
  end

  @doc false
  def changeset(career, attrs) do
    career
    |> cast(attrs, [:career_name])
    |> validate_required([:career_name])
    |> unique_constraint(:career_name)
  end
end
