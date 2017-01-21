defmodule Lyceum.Router do
  use Lyceum.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", Lyceum do
    pipe_through :api

    resources "/events", EventController, only: [:index, :create, :show] do
      resources "/candidates", CandidateController, only: [:index, :create]
    end
  end
end
