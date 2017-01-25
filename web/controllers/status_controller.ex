defmodule Lyceum.StatusController do
  use Lyceum.Web, :controller


  def index(conn, _params) do
    render(conn, "index.json", statuses: Status.list())
  end

end