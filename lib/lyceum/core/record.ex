defmodule Lyceum.Core.Record do
  import Ecto
  import Ecto.Query, only: [order_by: 2, preload: 2]
  alias Ecto.Multi
  alias Lyceum.{Repo, Record, RecordStatus}
  alias Lyceum.Core.Event

  def list(%{"event_id" => event_id}) do
    with {:ok, event} <- Event.show_info(%{"id" => event_id}) do
      event |> assoc(:records) |> order_by(:id) |> preload(:statuses) |> Repo.all
    end
  end

  def create(params) do
    with {:ok, %{record: record}} <- insert_record(params) do
      {:ok, Repo.preload(record, [:candidate, :statuses])}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
    end
  end

  def update(%{"id" => id, "status" => status_id}) do
    record = Repo.get(Record, id)
    with {:ok, _record_status} <- insert_status(%{record: record}, status_id) do
      {:ok, Repo.preload(record, [:candidate, :statuses])}
    end
  end

  defp insert_record(%{"event" => event_id, "candidate" => candidate_id, "status" => status_id}) do
    record_changeset = Record.changeset(%Record{}, %{event_id: event_id, candidate_id: candidate_id})
    Multi.new
    |> Multi.insert(:record, record_changeset)
    |> Multi.run(:status, &insert_status(&1, status_id))
    |> Repo.transaction
  end

  defp insert_status(%{record: record}, status_id) do
    %RecordStatus{}
    |> RecordStatus.changeset(%{status_id: status_id, record_id: record.id})
    |> Repo.insert
  end

end
