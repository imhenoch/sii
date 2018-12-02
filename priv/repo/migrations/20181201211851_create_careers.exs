defmodule Sii.Repo.Migrations.CreateCareers do
  use Ecto.Migration

  def change do
    create table(:careers) do
      add :career_name, :string

      timestamps()
    end

    create unique_index(:careers, [:career_name])
  end
end
