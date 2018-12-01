defmodule Sii.Repo.Migrations.CreatePeriods do
  use Ecto.Migration

  def change do
    create table(:periods) do
      add :year, :integer
      add :part, :integer

      timestamps()
    end

    create unique_index(:periods, [:year, :part], name: :periods_year_part_index)
  end
end
