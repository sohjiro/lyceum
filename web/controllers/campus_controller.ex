defmodule Lyceum.CampusController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Campus

  def index(conn, _params) do
    render(conn, "index.json", campuses: Campus.list())
  end

  def show(conn, params) do
    with {:ok, campus} <- Campus.get(params) do
      render(conn, "show.json", campus: campus)
    end
  end

end
