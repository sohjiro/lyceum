defmodule Lyceum.Core.Record do

  import Ecto
  alias Lyceum.{Repo, Record, Candidate}

  def create(params) do
    with {:ok, record} <- insert_record(params) do
      {:ok, record}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
    end
  end

  defp insert_record(params) do
    with {:ok, candidate} <- insert_candidate(params),
         {:ok, record} <- insert_record(candidate, params["event"]) do
      {:ok, Repo.preload(record, [:candidate, :statuses])}
    end
  end

  defp insert_candidate(params) do
    %Candidate{}
    |> Candidate.changeset(params)
    |> Repo.insert
  end

  defp insert_record(candidate, event_id) do
    candidate
    |> build_assoc(:records)
    |> Record.changeset(%{event_id: event_id})
    |> Repo.insert
  end

end
