defmodule Sii.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :control_number, :string
      add :password_hash, :string
      add :image, :string

      timestamps()
    end

    create unique_index(:students, [:email])
    create unique_index(:students, [:control_number])
  end
end
