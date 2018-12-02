defmodule Sii.Repo.Migrations.CreateKardexes do
  use Ecto.Migration

  def change do
    create table(:kardexes) do
      add :grade, :integer
      add :student_id, references(:students, on_delete: :nothing)
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :chance_id, references(:chances, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:kardexes, [:student_id, :subject_id, :chance_id],
             name: :kardexes_student_subject_chance_id
           )
  end
end
