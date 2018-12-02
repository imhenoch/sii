defmodule Sii.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :first_evaluation, :integer
      add :second_evaluation, :integer
      add :third_evaluation, :integer
      add :fourth_evaluation, :integer
      add :group_id, references(:groups, on_delete: :nothing)
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:lists, [:group_id, :student_id], name: :lists_group_student_id)
  end
end
