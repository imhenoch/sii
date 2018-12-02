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

  scope "/", SiiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", SiiWeb do
    pipe_through :api

    resources "/careers", CareerController, except: [:delete, :edit]
    resources "/periods", PeriodController, except: [:delete, :edit]
    resources "/departments", DepartmentController, except: [:delete, :edit]
    resources "/chances", ChanceController, except: [:delete, :edit]
    resources "/subjects", SubjectController, except: [:delete, :edit]
    resources "/students", StudentController, except: [:edit]
    resources "/teachers", TeacherController, except: [:edit]
    resources "/admins", AdminController, except: [:edit]
    resources "/groups", GroupController, except: [:delete, :edit]
  end
end
