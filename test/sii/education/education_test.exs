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
end
