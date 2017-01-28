defmodule Lyceum.StatusController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Status

  def index(conn, _params) do
    render(conn, "index.json", statuses: Status.list())
  end

  def show(conn, params) do
    with {:ok, status} <- Status.get(params) do
      render(conn, "show.json", status: status)
    end
  end

end
