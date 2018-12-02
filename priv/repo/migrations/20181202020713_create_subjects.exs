defmodule Sii.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :subject_name, :string
      add :career_id, references(:careers, on_delete: :nothing)

      timestamps()
    end

    create index(:subjects, [:career_id])
  end
end
