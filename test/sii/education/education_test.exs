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
end
