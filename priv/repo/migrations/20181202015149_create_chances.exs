defmodule Sii.Repo.Migrations.CreateChances do
  use Ecto.Migration

  def change do
    create table(:chances) do
      add :chance_description, :string

      timestamps()
    end

    create unique_index(:chances, [:chance_description])
  end
end
