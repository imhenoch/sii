defmodule Sii.Users.Student do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "students" do
    field :control_number, :string
    field :email, :string
    field :first_name, :string
    field :image, :string
    field :last_name, :string
    field :semester, :integer
    field :career_id, :id
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :control_number,
      :image,
      :password,
      :password_confirmation,
      :semester,
      :career_id
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :control_number,
      :password,
      :password_confirmation,
      :semester,
      :career_id
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> unique_constraint(:control_number)
    |> put_password_hash
  end

  @doc false
  def changeset_update(student, attrs) do
    student
    |> cast(attrs, [
      :email,
      :password,
      :password_confirmation
    ])
    |> validate_required([
      :email,
      :password,
      :password_confirmation
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
