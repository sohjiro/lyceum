defmodule Lyceum.SubjectController do
  use Lyceum.Web, :controller

  alias Lyceum.{Repo, Subject}

  def index(conn, _params) do
    render(conn, "index.json", subjects: Repo.all(Subject))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", subject: Repo.get(Subject, id))
  end

end
