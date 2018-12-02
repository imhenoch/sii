defmodule Sii.Users.Teacher do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "teachers" do
    field :control_number, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :department_id, :id
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :control_number,
      :department_id,
      :password,
      :password_confirmation
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :control_number,
      :department_id,
      :password,
      :password_confirmation
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> unique_constraint(:control_number)
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
