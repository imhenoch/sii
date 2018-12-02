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

  alias Sii.Education.Period

  @doc """
  Returns the list of periods.

  ## Examples

      iex> list_periods()
      [%Period{}, ...]

  """
  def list_periods do
    Repo.all(Period)
  end

  @doc """
  Gets a single period.

  Raises `Ecto.NoResultsError` if the Period does not exist.

  ## Examples

      iex> get_period!(123)
      %Period{}

      iex> get_period!(456)
      ** (Ecto.NoResultsError)

  """
  def get_period!(id), do: Repo.get!(Period, id)

  @doc """
  Creates a period.

  ## Examples

      iex> create_period(%{field: value})
      {:ok, %Period{}}

      iex> create_period(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_period(attrs \\ %{}) do
    %Period{}
    |> Period.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a period.

  ## Examples

      iex> update_period(period, %{field: new_value})
      {:ok, %Period{}}

      iex> update_period(period, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_period(%Period{} = period, attrs) do
    period
    |> Period.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Period.

  ## Examples

      iex> delete_period(period)
      {:ok, %Period{}}

      iex> delete_period(period)
      {:error, %Ecto.Changeset{}}

  """
  def delete_period(%Period{} = period) do
    Repo.delete(period)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking period changes.

  ## Examples

      iex> change_period(period)
      %Ecto.Changeset{source: %Period{}}

  """
  def change_period(%Period{} = period) do
    Period.changeset(period, %{})
  end

  alias Sii.Education.Department

  @doc """
  Returns the list of departments.

  ## Examples

      iex> list_departments()
      [%Department{}, ...]

  """
  def list_departments do
    Repo.all(Department)
  end

  @doc """
  Gets a single department.

  Raises `Ecto.NoResultsError` if the Department does not exist.

  ## Examples

      iex> get_department!(123)
      %Department{}

      iex> get_department!(456)
      ** (Ecto.NoResultsError)

  """
  def get_department!(id), do: Repo.get!(Department, id)

  @doc """
  Creates a department.

  ## Examples

      iex> create_department(%{field: value})
      {:ok, %Department{}}

      iex> create_department(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_department(attrs \\ %{}) do
    %Department{}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a department.

  ## Examples

      iex> update_department(department, %{field: new_value})
      {:ok, %Department{}}

      iex> update_department(department, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_department(%Department{} = department, attrs) do
    department
    |> Department.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Department.

  ## Examples

      iex> delete_department(department)
      {:ok, %Department{}}

      iex> delete_department(department)
      {:error, %Ecto.Changeset{}}

  """
  def delete_department(%Department{} = department) do
    Repo.delete(department)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking department changes.

  ## Examples

      iex> change_department(department)
      %Ecto.Changeset{source: %Department{}}

  """
  def change_department(%Department{} = department) do
    Department.changeset(department, %{})
  end

  alias Sii.Education.Chance

  @doc """
  Returns the list of chances.

  ## Examples

      iex> list_chances()
      [%Chance{}, ...]

  """
  def list_chances do
    Repo.all(Chance)
  end

  @doc """
  Gets a single chance.

  Raises `Ecto.NoResultsError` if the Chance does not exist.

  ## Examples

      iex> get_chance!(123)
      %Chance{}

      iex> get_chance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chance!(id), do: Repo.get!(Chance, id)

  @doc """
  Creates a chance.

  ## Examples

      iex> create_chance(%{field: value})
      {:ok, %Chance{}}

      iex> create_chance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chance(attrs \\ %{}) do
    %Chance{}
    |> Chance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chance.

  ## Examples

      iex> update_chance(chance, %{field: new_value})
      {:ok, %Chance{}}

      iex> update_chance(chance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chance(%Chance{} = chance, attrs) do
    chance
    |> Chance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Chance.

  ## Examples

      iex> delete_chance(chance)
      {:ok, %Chance{}}

      iex> delete_chance(chance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chance(%Chance{} = chance) do
    Repo.delete(chance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chance changes.

  ## Examples

      iex> change_chance(chance)
      %Ecto.Changeset{source: %Chance{}}

  """
  def change_chance(%Chance{} = chance) do
    Chance.changeset(chance, %{})
  end

  alias Sii.Education.Subject

  @doc """
  Returns the list of subjects.

  ## Examples

      iex> list_subjects()
      [%Subject{}, ...]

  """
  def list_subjects do
    Repo.all(Subject)
  end

  @doc """
  Gets a single subject.

  Raises `Ecto.NoResultsError` if the Subject does not exist.

  ## Examples

      iex> get_subject!(123)
      %Subject{}

      iex> get_subject!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subject!(id), do: Repo.get!(Subject, id)

  @doc """
  Creates a subject.

  ## Examples

      iex> create_subject(%{field: value})
      {:ok, %Subject{}}

      iex> create_subject(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subject(attrs \\ %{}) do
    %Subject{}
    |> Subject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subject.

  ## Examples

      iex> update_subject(subject, %{field: new_value})
      {:ok, %Subject{}}

      iex> update_subject(subject, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subject(%Subject{} = subject, attrs) do
    subject
    |> Subject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Subject.

  ## Examples

      iex> delete_subject(subject)
      {:ok, %Subject{}}

      iex> delete_subject(subject)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subject(%Subject{} = subject) do
    Repo.delete(subject)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subject changes.

  ## Examples

      iex> change_subject(subject)
      %Ecto.Changeset{source: %Subject{}}

  """
  def change_subject(%Subject{} = subject) do
    Subject.changeset(subject, %{})
  end

  alias Sii.Education.Group

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Group{}}

  """
  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end
end
