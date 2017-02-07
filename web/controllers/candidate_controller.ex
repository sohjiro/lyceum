defmodule Lyceum.CandidateController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Candidate

  def index(conn, _params) do
    render(conn, "index.json", candidates: Candidate.list())
  end

  def create(conn, %{"candidate" => candidate_params}) do
    with {:ok, candidate} <- Candidate.create(candidate_params) do
      conn
      |> put_status(:created)
      |> render("show.json", candidate: candidate)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

end
