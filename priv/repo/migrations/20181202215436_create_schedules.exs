defmodule Sii.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :day, :integer
      add :start_time, :string
      add :end_time, :string
      add :classroom, :string
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:schedules, [:group_id, :day], name: :schedules_group_day_index)
  end
end
