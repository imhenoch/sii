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
  end

  scope "/api", SiiWeb do
    pipe_through :api

    post "/student", StudentController, :sign_in
    post "/admin", AdminController, :sign_in

    # resources "/careers", CareerController, except: [:delete, :edit]
    # resources "/periods", PeriodController, except: [:delete, :edit]
    # resources "/departments", DepartmentController, except: [:delete, :edit]
    # resources "/chances", ChanceController, except: [:delete, :edit]
    # resources "/subjects", SubjectController, except: [:delete, :edit]
    # resources "/students", StudentController, except: [:edit]
    # resources "/teachers", TeacherController, except: [:edit]
    # resources "/admins", AdminController, except: [:edit]
    # resources "/groups", GroupController, except: [:delete, :edit]
    # resources "/lists", ListController, except: [:delete]
  end

  scope "/api", SiiWeb do
    pipe_through [:api, :students_authenticated]

    get "/student", StudentController, :profile
  end
end
