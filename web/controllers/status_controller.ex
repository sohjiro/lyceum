defmodule Lyceum.StatusController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Status

  def index(conn, _params) do
    render(conn, "index.json", statuses: Status.list())
  end

end
