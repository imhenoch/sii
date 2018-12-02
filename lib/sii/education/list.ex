defmodule Sii.Education.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :first_evaluation, :integer
    field :fourth_evaluation, :integer
    field :second_evaluation, :integer
    field :third_evaluation, :integer
    field :group_id, :id
    field :student_id, :id

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [
      :first_evaluation,
      :second_evaluation,
      :third_evaluation,
      :fourth_evaluation,
      :group_id,
      :student_id
    ])
    |> validate_required([
      :first_evaluation,
      :second_evaluation,
      :third_evaluation,
      :fourth_evaluation,
      :group_id,
      :student_id
    ])
    |> unique_constraint(:lists_group_student_id, name: :lists_group_student_id)
  end
end
