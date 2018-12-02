defmodule Sii.Education.Period do
  use Ecto.Schema
  import Ecto.Changeset

  schema "periods" do
    field :part, :integer
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(period, attrs) do
    period
    |> cast(attrs, [:year, :part])
    |> validate_required([:year, :part])
    |> unique_constraint(:periods_year_part_index, name: :periods_year_part_index)
  end
end
