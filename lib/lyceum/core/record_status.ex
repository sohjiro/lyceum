defmodule Lyceum.Core.RecordStatus do

  alias Lyceum.{Repo, RecordStatus}

  def create(%{"record" => record_id, "status" => status_id}) do
    %RecordStatus{}
    |> RecordStatus.changeset(%{status_id: status_id, record_id: record_id})
    |> Repo.insert
  end

end
