defmodule Lyceum.Router do
  use Lyceum.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", Lyceum do
    pipe_through :api

    resources "/events", EventController, only: [:index, :create, :show] do
      resources "/records", RecordController, only: [:index]
    end

    resources "/records", RecordController, only: [:create] do
      resources "/records_statuses", RecordStatusController, only: [:index]
    end
    resources "/records_statuses", RecordStatusController, only: [:create]

    resources "/candidates", CandidateController, only: [:index, :create, :show]
    resources "/statuses", StatusController, only: [:index, :show]
    resources "/campuses", CampusController, only: [:index, :show]
    resources "/types", TypeController, only: [:index, :show]
    resources "/subjects", SubjectController
  end
end
