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
end
