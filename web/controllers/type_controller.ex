defmodule Lyceum.TypeController do
  use Lyceum.Web, :controller

  alias Lyceum.{Repo, Type}

  def index(conn, _params) do
    render(conn, "index.json", types: Repo.all(Type))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", type: Repo.get(Type, id))
  end

end
