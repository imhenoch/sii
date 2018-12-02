defmodule Sii.Education.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :subject_name, :string
    field :career_id, :id

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:subject_name, :career_id])
    |> validate_required([:subject_name, :career_id])
  end
end
