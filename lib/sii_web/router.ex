defmodule SiiWeb.Router do
  use SiiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admins_authenticated do
    plug Sii.Guardian.AuthAdminPipeline
  end

  pipeline :students_authenticated do
    plug Sii.Guardian.AuthStudentPipeline
  end

  pipeline :teachers_authenticated do
    plug Sii.Guardian.AuthTeacherPipeline
  end

  scope "/", SiiWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/careers", CareerController
    resources "/departments", DepartmentController
    resources "/periods", PeriodController
    resources "/chances", ChanceController
    resources "/subjects", SubjectController
    resources "/students", StudentController
    resources "/teachers", TeacherController
    resources "/admins", AdminController
    resources "/groups", GroupController
    resources "/schedules", ScheduleController
    resources "/kardexes", KardexController
  end

  scope "/api", SiiWeb do
    pipe_through :api

    post "/student", StudentController, :sign_in
    post "/admin", AdminController, :sign_in
    post "/teacher", TeacherController, :sign_in
  end

  scope "/api", SiiWeb do
    pipe_through [:api, :admins_authenticated]

    get "/careers", CareerController, :index_json
    get "/careers/:id", CareerController, :show_json
    post "/careers", CareerController, :create_json
    put "/careers/:id", CareerController, :update_json
    delete "/careers/:id", CareerController, :delete_json

    get "/departments", DepartmentController, :index_json
    get "/departments/:id", DepartmentController, :show_json
    post "/departments", DepartmentController, :create_json
    put "/departments/:id", DepartmentController, :update_json
    delete "/departments/:id", DepartmentController, :delete_json

    get "/periods", PeriodController, :index_json
    get "/periods/:id", PeriodController, :show_json
    post "/periods", PeriodController, :create_json
    put "/periods/:id", PeriodController, :update_json
    delete "/periods/:id", PeriodController, :delete_json

    get "/chances", ChanceController, :index_json
    get "/chances/:id", ChanceController, :show_json
    post "/chances", ChanceController, :create_json
    put "/chances/:id", ChanceController, :update_json
    delete "/chances/:id", ChanceController, :delete_json

    get "/subjects", SubjectController, :index_json
    get "/subjects/:id", SubjectController, :show_json
    post "/subjects", SubjectController, :create_json
    put "/subjects/:id", SubjectController, :update_json
    delete "/subjects/:id", SubjectController, :delete_json

    get "/students", StudentController, :index_json
    get "/students/:id", StudentController, :show_json
    post "/students", StudentController, :create_json
    put "/students/:id", StudentController, :update_json
    delete "/students/:id", StudentController, :delete_json

    get "/teachers", TeacherController, :index_json
    get "/teachers/:id", TeacherController, :show_json
    post "/teachers", TeacherController, :create_json
    put "/teachers/:id", TeacherController, :update_json
    delete "/teachers/:id", TeacherController, :delete_json

    get "/admins", AdminController, :index_json
    get "/admins/:id", AdminController, :show_json
    post "/admins", AdminController, :create_json
    put "/admins/:id", AdminController, :update_json
    delete "/admins/:id", AdminController, :delete_json

    get "/groups", GroupController, :index_json
    get "/groups/:id", GroupController, :show_json
    post "/groups", GroupController, :create_json
    put "/groups/:id", GroupController, :update_json
    delete "/groups/:id", GroupController, :delete_json

    get "/schedules", ScheduleController, :index_json
    get "/schedules/:id", ScheduleController, :show_json
    post "/schedules", ScheduleController, :create_json
    put "/schedules/:id", ScheduleController, :update_json
    delete "/schedules/:id", ScheduleController, :delete_json

    get "/kardexes", KardexController, :index_json
    get "/kardexes/:id", KardexController, :show_json
    post "/kardexes", KardexController, :create_json
    put "/kardexes/:id", KardexController, :update_json
    delete "/kardexes/:id", KardexController, :delete_json

    resources "/lists", ListController, except: [:delete]
  end

  scope "/api", SiiWeb do
    pipe_through [:api, :students_authenticated]

    get "/student", StudentController, :profile
    put "/student", StudentController, :update_student_profile
    get "/student_subjects", StudentController, :student_subjects
    get "/kardex", StudentController, :student_kardex
    get "/schedule", StudentController, :student_schedule
    get "/available_groups", StudentController, :available_groups
    post "/subscribe", ListController, :create
  end

  scope "/api", SiiWeb do
    pipe_through [:api, :teachers_authenticated]

    get "/teacher", TeacherController, :profile
    put "/teacher", TeacherController, :update_teacher_profile
    get "/teacher_groups", TeacherController, :teacher_groups
    get "/list/:group_id", TeacherController, :group_list
    get "/grades/:id", ListController, :show
    put "/grades/:id", ListController, :update
  end
end
