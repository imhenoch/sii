defmodule Sii.Repo.Migrations.CreateDepartments do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :department_name, :string

      timestamps()
    end

    create unique_index(:departments, [:department_name])
  end
end
