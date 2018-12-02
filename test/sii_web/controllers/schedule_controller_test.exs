defmodule SiiWeb.ScheduleControllerTest do
  use SiiWeb.ConnCase

  alias Sii.Education
  alias Sii.Education.Schedule

  @create_attrs %{
    classroom: "some classroom",
    day: 42,
    end_time: "some end_time",
    start_time: "some start_time"
  }
  @update_attrs %{
    classroom: "some updated classroom",
    day: 43,
    end_time: "some updated end_time",
    start_time: "some updated start_time"
  }
  @invalid_attrs %{classroom: nil, day: nil, end_time: nil, start_time: nil}

  def fixture(:schedule) do
    {:ok, schedule} = Education.create_schedule(@create_attrs)
    schedule
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all schedules", %{conn: conn} do
      conn = get(conn, Routes.schedule_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create schedule" do
    test "renders schedule when data is valid", %{conn: conn} do
      conn = post(conn, Routes.schedule_path(conn, :create), schedule: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.schedule_path(conn, :show, id))

      assert %{
               "id" => id,
               "classroom" => "some classroom",
               "day" => 42,
               "end_time" => "some end_time",
               "start_time" => "some start_time"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.schedule_path(conn, :create), schedule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update schedule" do
    setup [:create_schedule]

    test "renders schedule when data is valid", %{conn: conn, schedule: %Schedule{id: id} = schedule} do
      conn = put(conn, Routes.schedule_path(conn, :update, schedule), schedule: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.schedule_path(conn, :show, id))

      assert %{
               "id" => id,
               "classroom" => "some updated classroom",
               "day" => 43,
               "end_time" => "some updated end_time",
               "start_time" => "some updated start_time"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, schedule: schedule} do
      conn = put(conn, Routes.schedule_path(conn, :update, schedule), schedule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete schedule" do
    setup [:create_schedule]

    test "deletes chosen schedule", %{conn: conn, schedule: schedule} do
      conn = delete(conn, Routes.schedule_path(conn, :delete, schedule))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.schedule_path(conn, :show, schedule))
      end
    end
  end

  defp create_schedule(_) do
    schedule = fixture(:schedule)
    {:ok, schedule: schedule}
  end
end
