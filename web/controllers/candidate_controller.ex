defmodule Lyceum.CandidateController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Candidate

  def index(conn, params) do
    render(conn, "index.json", candidates: Candidate.list(params))
  end

  def show(conn, params) do
    with {:ok, candidate} <- Candidate.show_info(params) do
      render(conn, "show.json", candidate: candidate)
    end
  end

  def update(conn, params) do
    with {:ok, candidate} <- Candidate.update(params) do
      conn
      |> put_status(:accepted)
      |> render("show.json", candidate: candidate)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

  def create(conn, %{"candidate" => params}) do
    with {:ok, candidate} <- Candidate.create(params) do
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
