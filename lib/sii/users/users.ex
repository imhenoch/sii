defmodule Sii.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Sii.Repo
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Sii.Education.List
  alias Sii.Education.Career
  alias Sii.Education.Group
  alias Sii.Education.Subject
  alias Sii.Education.Kardex
  alias Sii.Education.Chance
  alias Sii.Education.Schedule
  alias Sii.Users.Student
  alias Sii.Users.Teacher
  alias Sii.Users.Admin
  alias Sii.Admin.Guardian, as: AdminGuardian
  alias Sii.Teacher.Guardian, as: TeacherGuardian
  alias Sii.Student.Guardian, as: StudentGuardian

  def student_sign_in(control_number, password) do
    case student_auth(control_number, password) do
      {:ok, student} ->
        StudentGuardian.encode_and_sign(student)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp student_auth(control_number, password)
       when is_binary(control_number) and is_binary(password) do
    with {:ok, student} <- get_student_by_control_number(control_number),
         do: verify_student_password(password, student)
  end

  defp get_student_by_control_number(control_number) when is_binary(control_number) do
    case Repo.get_by(Student, control_number: control_number) do
      nil ->
        dummy_checkpw()
        {:error, "Login error"}

      student ->
        {:ok, student}
    end
  end

  defp verify_student_password(password, %Student{} = student) when is_binary(password) do
    if checkpw(password, student.password_hash) do
      {:ok, student}
    else
      {:error, :invalid_password}
    end
  end

  def list_student_subjects(id) do
    query =
      from s in Student,
        join: l in List,
        on: s.id == l.student_id,
        join: g in Group,
        on: g.id == l.group_id,
        join: sub in Subject,
        on: sub.id == g.subject_id,
        join: t in Teacher,
        on: t.id == g.teacher_id,
        where: s.id == ^id,
        select: %{
          group_id: g.id,
          letter: g.letter,
          subject_name: sub.subject_name,
          teacher_email: t.email,
          teacher_first_name: t.first_name,
          teacher_last_name: t.last_name,
          first_evaluation: l.first_evaluation,
          second_evaluation: l.second_evaluation,
          third_evaluation: l.third_evaluation,
          fourth_evaluation: l.fourth_evaluation
        }

    Repo.all(query)
  end

  def list_student_kardex(id) do
    query =
      from s in Student,
        join: k in Kardex,
        on: s.id == k.student_id,
        join: sub in Subject,
        on: sub.id == k.subject_id,
        join: c in Chance,
        on: c.id == k.chance_id,
        where: s.id == ^id,
        select: %{
          subject_name: sub.subject_name,
          grade: k.grade,
          chance_description: c.chance_description
        }

    Repo.all(query)
  end

  def list_student_shcedule(id) do
    query =
      from s in Student,
        join: l in List,
        on: s.id == l.student_id,
        join: g in Group,
        on: g.id == l.group_id,
        join: sub in Subject,
        on: sub.id == g.subject_id,
        join: sc in Schedule,
        on: g.id == sc.group_id,
        where: s.id == ^id and g.open == true,
        select: %{
          id: g.id,
          subject_name: sub.subject_name,
          letter: g.letter,
          day: sc.day,
          start_time: sc.start_time,
          end_time: sc.end_time,
          classroom: sc.classroom
        }

    Repo.all(query)
  end

  def list_available_groups(career_id) do
    query =
      from g in Group,
        join: s in Subject,
        on: s.id == g.subject_id,
        where: g.open == true and s.career_id == ^career_id,
        select: %{
          id: g.id,
          subject_name: s.subject_name,
          letter: g.letter
        }

    Repo.all(query)
  end

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  def update_student_profile(%Student{} = student, attrs) do
    student
    |> Student.changeset_update(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{source: %Student{}}

  """
  def change_student(%Student{} = student) do
    Student.changeset(student, %{})
  end

  def teacher_sign_in(control_number, password) do
    case teacher_auth(control_number, password) do
      {:ok, teacher} ->
        TeacherGuardian.encode_and_sign(teacher)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp teacher_auth(control_number, password)
       when is_binary(control_number) and is_binary(password) do
    with {:ok, teacher} <- get_teacher_by_control_number(control_number),
         do: verify_teacher_password(password, teacher)
  end

  defp get_teacher_by_control_number(control_number) when is_binary(control_number) do
    case Repo.get_by(Teacher, control_number: control_number) do
      nil ->
        dummy_checkpw()
        {:error, "Login error"}

      teacher ->
        {:ok, teacher}
    end
  end

  defp verify_teacher_password(password, %Teacher{} = teacher) when is_binary(password) do
    if checkpw(password, teacher.password_hash) do
      {:ok, teacher}
    else
      {:error, :invalid_password}
    end
  end

  def list_teacher_groups(teacher_id) do
    query =
      from g in Group,
        join: s in Subject,
        on: s.id == g.subject_id,
        join: c in Career,
        on: c.id == s.career_id,
        where: g.teacher_id == ^teacher_id,
        select: %{
          group_id: g.id,
          subject_name: s.subject_name,
          letter: g.letter,
          career_name: c.career_name
        }

    Repo.all(query)
  end

  def list_group_students(group_id) do
    query =
      from l in List,
        join: s in Student,
        on: s.id == l.student_id,
        where: l.group_id == ^group_id,
        select: %{
          student_id: s.id,
          student_first_name: s.first_name,
          student_last_name: s.last_name,
          list_id: l.id,
          student_email: s.email
        }

    Repo.all(query)
  end

  @doc """
  Returns the list of teachers.

  ## Examples

      iex> list_teachers()
      [%Teacher{}, ...]

  """
  def list_teachers do
    Repo.all(Teacher)
  end

  @doc """
  Gets a single teacher.

  Raises `Ecto.NoResultsError` if the Teacher does not exist.

  ## Examples

      iex> get_teacher!(123)
      %Teacher{}

      iex> get_teacher!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teacher!(id), do: Repo.get!(Teacher, id)

  @doc """
  Creates a teacher.

  ## Examples

      iex> create_teacher(%{field: value})
      {:ok, %Teacher{}}

      iex> create_teacher(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teacher(attrs \\ %{}) do
    %Teacher{}
    |> Teacher.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teacher.

  ## Examples

      iex> update_teacher(teacher, %{field: new_value})
      {:ok, %Teacher{}}

      iex> update_teacher(teacher, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teacher(%Teacher{} = teacher, attrs) do
    teacher
    |> Teacher.changeset(attrs)
    |> Repo.update()
  end

  def update_teacher_profile(%Teacher{} = teacher, attrs) do
    teacher
    |> Teacher.changeset_update(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Teacher.

  ## Examples

      iex> delete_teacher(teacher)
      {:ok, %Teacher{}}

      iex> delete_teacher(teacher)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teacher(%Teacher{} = teacher) do
    Repo.delete(teacher)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teacher changes.

  ## Examples

      iex> change_teacher(teacher)
      %Ecto.Changeset{source: %Teacher{}}

  """
  def change_teacher(%Teacher{} = teacher) do
    Teacher.changeset(teacher, %{})
  end

  def admin_sign_in(email, password) do
    case admin_auth(email, password) do
      {:ok, admin} ->
        AdminGuardian.encode_and_sign(admin)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp admin_auth(email, password)
       when is_binary(email) and is_binary(password) do
    with {:ok, admin} <- get_admin_by_email(email),
         do: verify_admin_password(password, admin)
  end

  defp get_admin_by_email(email) when is_binary(email) do
    case Repo.get_by(Admin, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error"}

      admin ->
        {:ok, admin}
    end
  end

  defp verify_admin_password(password, %Admin{} = admin) when is_binary(password) do
    if checkpw(password, admin.password_hash) do
      {:ok, admin}
    else
      {:error, :invalid_password}
    end
  end

  @doc """
  Returns the list of admins.

  ## Examples

      iex> list_admins()
      [%Admin{}, ...]

  """
  def list_admins do
    Repo.all(Admin)
  end

  @doc """
  Gets a single admin.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> get_admin!(123)
      %Admin{}

      iex> get_admin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin!(id), do: Repo.get!(Admin, id)

  @doc """
  Creates a admin.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %Admin{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin(attrs \\ %{}) do
    %Admin{}
    |> Admin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin.

  ## Examples

      iex> update_admin(admin, %{field: new_value})
      {:ok, %Admin{}}

      iex> update_admin(admin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Admin.

  ## Examples

      iex> delete_admin(admin)
      {:ok, %Admin{}}

      iex> delete_admin(admin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin(%Admin{} = admin) do
    Repo.delete(admin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin changes.

  ## Examples

      iex> change_admin(admin)
      %Ecto.Changeset{source: %Admin{}}

  """
  def change_admin(%Admin{} = admin) do
    Admin.changeset(admin, %{})
  end
end
