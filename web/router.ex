defmodule Lyceum.Router do
  use Lyceum.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", Lyceum do
    pipe_through :api

    resources "/events", EventController, only: [:index, :create, :show]
    resources "/records", RecordController, only: [:index, :create, :update]
    resources "/statuses", StatusController, only: [:index, :show]
    resources "/campuses", CampusController, only: [:index, :show]
    resources "/types", TypeController, only: [:index, :show]
    resources "/subjects", SubjectController
  end
end
