defmodule Sii.UsersTest do
  use Sii.DataCase

  alias Sii.Users

  describe "students" do
    alias Sii.Users.Student

    @valid_attrs %{control_number: "some control_number", email: "some email", first_name: "some first_name", image: "some image", last_name: "some last_name", password_hash: "some password_hash"}
    @update_attrs %{control_number: "some updated control_number", email: "some updated email", first_name: "some updated first_name", image: "some updated image", last_name: "some updated last_name", password_hash: "some updated password_hash"}
    @invalid_attrs %{control_number: nil, email: nil, first_name: nil, image: nil, last_name: nil, password_hash: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Users.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Users.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Users.create_student(@valid_attrs)
      assert student.control_number == "some control_number"
      assert student.email == "some email"
      assert student.first_name == "some first_name"
      assert student.image == "some image"
      assert student.last_name == "some last_name"
      assert student.password_hash == "some password_hash"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Users.update_student(student, @update_attrs)
      assert student.control_number == "some updated control_number"
      assert student.email == "some updated email"
      assert student.first_name == "some updated first_name"
      assert student.image == "some updated image"
      assert student.last_name == "some updated last_name"
      assert student.password_hash == "some updated password_hash"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_student(student, @invalid_attrs)
      assert student == Users.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Users.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Users.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Users.change_student(student)
    end
  end

  describe "teachers" do
    alias Sii.Users.Teacher

    @valid_attrs %{control_number: "some control_number", email: "some email", first_name: "some first_name", last_name: "some last_name", password_hash: "some password_hash"}
    @update_attrs %{control_number: "some updated control_number", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password_hash: "some updated password_hash"}
    @invalid_attrs %{control_number: nil, email: nil, first_name: nil, last_name: nil, password_hash: nil}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert Users.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert Users.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = Users.create_teacher(@valid_attrs)
      assert teacher.control_number == "some control_number"
      assert teacher.email == "some email"
      assert teacher.first_name == "some first_name"
      assert teacher.last_name == "some last_name"
      assert teacher.password_hash == "some password_hash"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = Users.update_teacher(teacher, @update_attrs)
      assert teacher.control_number == "some updated control_number"
      assert teacher.email == "some updated email"
      assert teacher.first_name == "some updated first_name"
      assert teacher.last_name == "some updated last_name"
      assert teacher.password_hash == "some updated password_hash"
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_teacher(teacher, @invalid_attrs)
      assert teacher == Users.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = Users.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> Users.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = Users.change_teacher(teacher)
    end
  end

  describe "admins" do
    alias Sii.Users.Admin

    @valid_attrs %{email: "some email", password_hash: "some password_hash"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash"}
    @invalid_attrs %{email: nil, password_hash: nil}

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_admin()

      admin
    end

    test "list_admins/0 returns all admins" do
      admin = admin_fixture()
      assert Users.list_admins() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Users.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Users.create_admin(@valid_attrs)
      assert admin.email == "some email"
      assert admin.password_hash == "some password_hash"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{} = admin} = Users.update_admin(admin, @update_attrs)
      assert admin.email == "some updated email"
      assert admin.password_hash == "some updated password_hash"
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_admin(admin, @invalid_attrs)
      assert admin == Users.get_admin!(admin.id)
    end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Users.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Users.get_admin!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Users.change_admin(admin)
    end
  end
end
