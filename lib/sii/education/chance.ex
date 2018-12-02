defmodule Sii.Education.Chance do
  use Ecto.Schema
  import Ecto.Changeset


  schema "chances" do
    field :chance_description, :string

    timestamps()
  end

  @doc false
  def changeset(chance, attrs) do
    chance
    |> cast(attrs, [:chance_description])
    |> validate_required([:chance_description])
    |> unique_constraint(:chance_description)
  end
end
