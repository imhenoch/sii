defmodule Sii.EducationTest do
  use Sii.DataCase

  alias Sii.Education

  describe "careers" do
    alias Sii.Education.Career

    @valid_attrs %{career_name: "some career_name"}
    @update_attrs %{career_name: "some updated career_name"}
    @invalid_attrs %{career_name: nil}

    def career_fixture(attrs \\ %{}) do
      {:ok, career} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Education.create_career()

      career
    end

    test "list_careers/0 returns all careers" do
      career = career_fixture()
      assert Education.list_careers() == [career]
    end

    test "get_career!/1 returns the career with given id" do
      career = career_fixture()
      assert Education.get_career!(career.id) == career
    end

    test "create_career/1 with valid data creates a career" do
      assert {:ok, %Career{} = career} = Education.create_career(@valid_attrs)
      assert career.career_name == "some career_name"
    end

    test "create_career/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Education.create_career(@invalid_attrs)
    end

    test "update_career/2 with valid data updates the career" do
      career = career_fixture()
      assert {:ok, %Career{} = career} = Education.update_career(career, @update_attrs)
      assert career.career_name == "some updated career_name"
    end

    test "update_career/2 with invalid data returns error changeset" do
      career = career_fixture()
      assert {:error, %Ecto.Changeset{}} = Education.update_career(career, @invalid_attrs)
      assert career == Education.get_career!(career.id)
    end

    test "delete_career/1 deletes the career" do
      career = career_fixture()
      assert {:ok, %Career{}} = Education.delete_career(career)
      assert_raise Ecto.NoResultsError, fn -> Education.get_career!(career.id) end
    end

    test "change_career/1 returns a career changeset" do
      career = career_fixture()
      assert %Ecto.Changeset{} = Education.change_career(career)
    end
  end

  describe "periods" do
    alias Sii.Education.Period

    @valid_attrs %{part: 42, year: 42}
    @update_attrs %{part: 43, year: 43}
    @invalid_attrs %{part: nil, year: nil}

    def period_fixture(attrs \\ %{}) do
      {:ok, period} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Education.create_period()

      period
    end

    test "list_periods/0 returns all periods" do
      period = period_fixture()
      assert Education.list_periods() == [period]
    end

    test "get_period!/1 returns the period with given id" do
      period = period_fixture()
      assert Education.get_period!(period.id) == period
    end

    test "create_period/1 with valid data creates a period" do
      assert {:ok, %Period{} = period} = Education.create_period(@valid_attrs)
      assert period.part == 42
      assert period.year == 42
    end

    test "create_period/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Education.create_period(@invalid_attrs)
    end

    test "update_period/2 with valid data updates the period" do
      period = period_fixture()
      assert {:ok, %Period{} = period} = Education.update_period(period, @update_attrs)
      assert period.part == 43
      assert period.year == 43
    end

    test "update_period/2 with invalid data returns error changeset" do
      period = period_fixture()
      assert {:error, %Ecto.Changeset{}} = Education.update_period(period, @invalid_attrs)
      assert period == Education.get_period!(period.id)
    end

    test "delete_period/1 deletes the period" do
      period = period_fixture()
      assert {:ok, %Period{}} = Education.delete_period(period)
      assert_raise Ecto.NoResultsError, fn -> Education.get_period!(period.id) end
    end

    test "change_period/1 returns a period changeset" do
      period = period_fixture()
      assert %Ecto.Changeset{} = Education.change_period(period)
    end
  end

  describe "departments" do
    alias Sii.Education.Department

    @valid_attrs %{department_name: "some department_name"}
    @update_attrs %{department_name: "some updated department_name"}
    @invalid_attrs %{department_name: nil}

    def department_fixture(attrs \\ %{}) do
      {:ok, department} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Education.create_department()

      department
    end

    test "list_departments/0 returns all departments" do
      department = department_fixture()
      assert Education.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      department = department_fixture()
      assert Education.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      assert {:ok, %Department{} = department} = Education.create_department(@valid_attrs)
      assert department.department_name == "some department_name"
    end

    test "create_department/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Education.create_department(@invalid_attrs)
    end

    test "update_department/2 with valid data updates the department" do
      department = department_fixture()
      assert {:ok, %Department{} = department} = Education.update_department(department, @update_attrs)
      assert department.department_name == "some updated department_name"
    end

    test "update_department/2 with invalid data returns error changeset" do
      department = department_fixture()
      assert {:error, %Ecto.Changeset{}} = Education.update_department(department, @invalid_attrs)
      assert department == Education.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      department = department_fixture()
      assert {:ok, %Department{}} = Education.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> Education.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      department = department_fixture()
      assert %Ecto.Changeset{} = Education.change_department(department)
    end
  end

  describe "chances" do
    alias Sii.Education.Chance

    @valid_attrs %{chance_description: "some chance_description"}
    @update_attrs %{chance_description: "some updated chance_description"}
    @invalid_attrs %{chance_description: nil}

    def chance_fixture(attrs \\ %{}) do
      {:ok, chance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Education.create_chance()

      chance
    end

    test "list_chances/0 returns all chances" do
      chance = chance_fixture()
      assert Education.list_chances() == [chance]
    end

    test "get_chance!/1 returns the chance with given id" do
      chance = chance_fixture()
      assert Education.get_chance!(chance.id) == chance
    end

    test "create_chance/1 with valid data creates a chance" do
      assert {:ok, %Chance{} = chance} = Education.create_chance(@valid_attrs)
      assert chance.chance_description == "some chance_description"
    end

    test "create_chance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Education.create_chance(@invalid_attrs)
    end

    test "update_chance/2 with valid data updates the chance" do
      chance = chance_fixture()
      assert {:ok, %Chance{} = chance} = Education.update_chance(chance, @update_attrs)
      assert chance.chance_description == "some updated chance_description"
    end

    test "update_chance/2 with invalid data returns error changeset" do
      chance = chance_fixture()
      assert {:error, %Ecto.Changeset{}} = Education.update_chance(chance, @invalid_attrs)
      assert chance == Education.get_chance!(chance.id)
    end

    test "delete_chance/1 deletes the chance" do
      chance = chance_fixture()
      assert {:ok, %Chance{}} = Education.delete_chance(chance)
      assert_raise Ecto.NoResultsError, fn -> Education.get_chance!(chance.id) end
    end

    test "change_chance/1 returns a chance changeset" do
      chance = chance_fixture()
      assert %Ecto.Changeset{} = Education.change_chance(chance)
    end
  end

  describe "subjects" do
    alias Sii.Education.Subject

    @valid_attrs %{subject_name: "some subject_name"}
    @update_attrs %{subject_name: "some updated subject_name"}
    @invalid_attrs %{subject_name: nil}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Education.create_subject()

      subject
    end

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert Education.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Education.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      assert {:ok, %Subject{} = subject} = Education.create_subject(@valid_attrs)
      assert subject.subject_name == "some subject_name"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Education.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{} = subject} = Education.update_subject(subject, @update_attrs)
      assert subject.subject_name == "some updated subject_name"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = Education.update_subject(subject, @invalid_attrs)
      assert subject == Education.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = Education.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> Education.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = Education.change_subject(subject)
    end
  end

  describe "groups" do
    alias Sii.Education.Group

    @valid_attrs %{letter: "some letter", open: true}
    @update_attrs %{letter: "some updated letter", open: false}
    @invalid_attrs %{letter: nil, open: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Education.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Education.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Education.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Education.create_group(@valid_attrs)
      assert group.letter == "some letter"
      assert group.open == true
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Education.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, %Group{} = group} = Education.update_group(group, @update_attrs)
      assert group.letter == "some updated letter"
      assert group.open == false
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Education.update_group(group, @invalid_attrs)
      assert group == Education.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Education.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Education.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Education.change_group(group)
    end
  end
end
