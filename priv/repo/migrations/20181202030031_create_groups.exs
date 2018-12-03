defmodule Sii.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :letter, :string
      add :open, :boolean, default: false, null: false
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :teacher_id, references(:teachers, on_delete: :nothing)
      add :period, references(:periods, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:groups, [:subject_id, :teacher_id, :period, :letter],
             name: :groups_teacher_subjet_letter_period_index
           )
  end
end
