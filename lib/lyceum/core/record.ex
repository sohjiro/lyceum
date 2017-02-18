defmodule Lyceum.Core.Record do
  import Ecto
  import Ecto.Query, only: [order_by: 2, preload: 2]
  alias Ecto.Multi
  alias Lyceum.{Repo, Record}
  alias Lyceum.Core.{Event, Candidate}

  def info(%{"record_id" => id}) do
    case Repo.get(Record, id) do
      nil -> {:error, :not_found}
      record -> {:ok, Repo.preload(record, [:candidate, :statuses])}
    end
  end

  def list(%{"candidate_id" => candidate_id}) do
    with {:ok, candidate} <- Candidate.show_info(%{"id" => candidate_id}) do
      candidate |> assoc(:records) |> order_by(:id) |> preload(:statuses) |> Repo.all
    end
  end

  def list(%{"event_id" => event_id}) do
    with {:ok, event} <- Event.show_info(%{"id" => event_id}) do
      event |> assoc(:records) |> order_by(:id) |> preload(:statuses) |> Repo.all
    end
  end

  def update(params) do
    with {:ok, record} <- update_record(params) do
      {:ok, Repo.preload(record, [:candidate, :statuses])}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
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

  defp insert_record(%{"event" => event_id, "candidate" => candidate_id} = params) do
    params = params
             |> Map.put("event_id", event_id)
             |> Map.put("candidate_id", candidate_id)

    record_changeset = Record.changeset(%Record{}, params)
    Multi.new
    |> Multi.insert(:record, record_changeset)
    |> Repo.transaction
  end

  defp update_record(%{"id" => record_id, "record" => params}) do
    with {:ok, record} <- info(%{"record_id" => record_id}) do
      record
      |> Record.changeset(params)
      |> Repo.update
    end
  end

end
