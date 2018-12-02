defmodule Sii.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :control_number, :string
      add :password_hash, :string
      add :department_id, references(:departments, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:teachers, [:email])
    create unique_index(:teachers, [:control_number])
  end
end
