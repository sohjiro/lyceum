defmodule Lyceum.Core.Record do
  import Ecto

  alias Ecto.Multi
  alias Lyceum.{Repo, Record, RecordStatus, Candidate}

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

  defp insert_record(params) do
    candidate_changeset = Candidate.changeset(%Candidate{}, params)
    Multi.new
    |> Multi.insert(:candidate, candidate_changeset)
    |> Multi.run(:record, &insert_record(&1, params["event"]))
    |> Multi.run(:status, &insert_status(&1, params["status"]))
    |> Repo.transaction
  end

  defp insert_record(%{candidate: candidate}, event_id) do
    candidate
    |> build_assoc(:records)
    |> Record.changeset(%{event_id: event_id})
    |> Repo.insert
  end

  defp insert_status(%{record: record}, status_id) do
    %RecordStatus{}
    |> RecordStatus.changeset(%{status_id: status_id, record_id: record.id})
    |> Repo.insert
  end

end
