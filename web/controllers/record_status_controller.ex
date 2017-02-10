defmodule Lyceum.RecordStatusController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.RecordStatus

  def create(conn, %{"recordStatus" => params}) do
    with {:ok, record_status} <- RecordStatus.create(params) do
      render(conn, "show.json", record_status: record_status)
    end
  end

end
