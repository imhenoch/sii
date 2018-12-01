defmodule Sii.Education do
  @moduledoc """
  The Education context.
  """

  import Ecto.Query, warn: false
  alias Sii.Repo

  alias Sii.Education.Career

  @doc """
  Returns the list of careers.

  ## Examples

      iex> list_careers()
      [%Career{}, ...]

  """
  def list_careers do
    Repo.all(Career)
  end

  @doc """
  Gets a single career.

  Raises `Ecto.NoResultsError` if the Career does not exist.

  ## Examples

      iex> get_career!(123)
      %Career{}

      iex> get_career!(456)
      ** (Ecto.NoResultsError)

  """
  def get_career!(id), do: Repo.get!(Career, id)

  @doc """
  Creates a career.

  ## Examples

      iex> create_career(%{field: value})
      {:ok, %Career{}}

      iex> create_career(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_career(attrs \\ %{}) do
    %Career{}
    |> Career.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a career.

  ## Examples

      iex> update_career(career, %{field: new_value})
      {:ok, %Career{}}

      iex> update_career(career, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_career(%Career{} = career, attrs) do
    career
    |> Career.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Career.

  ## Examples

      iex> delete_career(career)
      {:ok, %Career{}}

      iex> delete_career(career)
      {:error, %Ecto.Changeset{}}

  """
  def delete_career(%Career{} = career) do
    Repo.delete(career)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking career changes.

  ## Examples

      iex> change_career(career)
      %Ecto.Changeset{source: %Career{}}

  """
  def change_career(%Career{} = career) do
    Career.changeset(career, %{})
  end
end
