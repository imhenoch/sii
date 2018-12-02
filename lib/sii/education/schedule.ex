defmodule Sii.Education.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :classroom, :string
    field :day, :integer
    field :end_time, :string
    field :start_time, :string
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:day, :start_time, :end_time, :classroom])
    |> validate_required([:day, :start_time, :end_time, :classroom])
    |> unique_constraint(:schedules_group_day_index, name: :schedules_group_day_index)
  end
end
