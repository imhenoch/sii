defmodule Sii.Education.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :letter, :string
    field :open, :boolean, default: false
    field :subject_id, :id
    field :teacher_id, :id
    field :period, :id

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:letter, :open, :subject_id, :teacher_id, :period])
    |> validate_required([:letter, :open, :subject_id, :teacher_id, :period])
  end
end
