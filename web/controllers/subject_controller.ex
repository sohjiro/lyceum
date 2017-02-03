defmodule Lyceum.SubjectController do
  use Lyceum.Web, :controller

  alias Lyceum.{Repo, Subject}

  def index(conn, _params) do
    render(conn, "index.json", types: Repo.all(Subject))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", type: Repo.get(Subject, id))
  end

end
