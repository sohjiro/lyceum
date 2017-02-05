defmodule Lyceum.SubjectController do
  use Lyceum.Web, :controller

  alias Lyceum.{Repo, Subject}

  def index(conn, _params) do
    render(conn, "index.json", subjects: Repo.all(Subject))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", subject: Repo.get(Subject, id))
  end

  def update(conn, %{"id" => id, "subject" => params}) do
    changeset = Repo.get(Subject, id) |> Subject.changeset(params)
    with {:ok, subject} <- Repo.update(changeset) do
      render(conn, "show.json", subject: subject)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

  def create(conn, %{"subject" => params}) do
    changeset = Subject.changeset(%Subject{}, params)
    with {:ok, subject} <- Repo.insert(changeset) do
      render(conn, "show.json", subject: subject)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

end
