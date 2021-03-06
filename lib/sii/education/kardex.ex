defmodule Sii.Education.Kardex do
  use Ecto.Schema
  import Ecto.Changeset

  schema "kardexes" do
    field :grade, :integer
    field :student_id, :id
    field :subject_id, :id
    field :chance_id, :id

    timestamps()
  end

  @doc false
  def changeset(kardex, attrs) do
    kardex
    |> cast(attrs, [:grade, :student_id, :subject_id, :chance_id])
    |> validate_required([:grade, :student_id, :subject_id, :chance_id])
    |> unique_constraint(:kardexes_student_subject_chance_id,
      name: :kardexes_student_subject_chance_id
    )
  end
end
