defmodule Lyceum.Router do
  use Lyceum.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", Lyceum do
    pipe_through :api

    resources "/events", EventController, only: [:index, :create, :show] do
      resources "/candidates", CandidateController, only: [:index]
    end
    resources "/candidates", CandidateController, only: [:create, :show, :update]
    resources "/statuses", StatusController, only: [:index, :show]
    resources "/campuses", CampusController, only: [:index, :show]
    resources "/types", TypeController, only: [:index, :show]
    resources "/subjects", SubjectController, only: [:index, :show, :create]
  end
end
