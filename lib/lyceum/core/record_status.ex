defmodule Lyceum.Core.RecordStatus do

  alias Lyceum.Core.Record
  alias Lyceum.{Repo, RecordStatus}

  def list(params) do
    with {:ok, record} <- Record.info(params) do
      record |> Ecto.assoc(:statuses) |> Repo.all
    end
  end

  def create(%{"record" => record_id, "status" => status_id}) do
    last_record = %{"record_id" => record_id}
                  |> list
                  |> hd

    cond do
      last_record.status_id == status_id && last_record.record_id == record_id ->
        {:ok, last_record}
      true ->
        %RecordStatus{}
        |> RecordStatus.changeset(%{status_id: status_id, record_id: record_id})
        |> Repo.insert
    end
  end

end
