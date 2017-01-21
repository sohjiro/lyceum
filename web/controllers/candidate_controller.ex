defmodule Lyceum.CandidateController do
  use Lyceum.Web, :controller

  alias Lyceum.Repo
  alias Lyceum.Core.Candidate

  def index(conn, params) do
    render(conn, "index.json", candidates: Candidate.list_for_event(params))
  end

  def create(conn, %{"event_id" => event_id, "candidate" => params}) do
    with {:ok, candidate} <- Candidate.create(event_id, params) do
      conn
      |> put_status(:created)
      |> render("show.json", candidate: Repo.preload(candidate, :event))
    end
  end

end
