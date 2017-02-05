defmodule Lyceum.Core.Candidate do
  import Ecto
  import Ecto.Query, only: [last: 2, order_by: 2]
  alias Ecto.Multi
  alias Lyceum.{Repo, Candidate, CandidateStatus}

  def list(%{"event_id" => event_id}) do
    with {:ok, event} <- Lyceum.Core.Event.show_info(%{"id" => event_id}) do
      event |> fetch_candidates
    else
      _ -> []
    end
  end

  def list(%{"campus_id" => campus_id}) do
    with {:ok, campus} <- Lyceum.Core.Campus.get(%{"id" => campus_id}) do
      campus |> fetch_candidates
    else
      _ -> []
    end
  end

  def show_info(%{"id" => id}) do
    case Repo.get(Candidate, id) do
      nil -> {:error, :not_found}
      candidate -> {:ok, map_current_status(candidate)}
    end
  end

  def update(%{"id" => id, "candidate" => params}) do
    with {:ok, %{candidate: candidate}} <- do_update(id, params) do
      candidate = candidate |> Repo.preload([:event, :statuses]) |> map_current_status
      {:ok, candidate}
    end
  end

  def create(params) do
    with {:ok, %{candidate: candidate}} <- insert(params) do
      candidate = candidate |> Repo.preload([:event, :statuses]) |> map_current_status
      {:ok, candidate}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
    end
  end

  defp do_update(id, params) do
    changeset = Candidate |> Repo.get(id) |> Candidate.changeset(params)

    Multi.new
    |> Multi.update(:candidate, changeset)
    |> Multi.run(:tracking, &generate_tracking(&1, params["status"]))
    |> Repo.transaction
  end

  defp insert(params) do
    params
    |> generate_changeset
    |> execute_transaction(params["status"])
  end

  defp generate_changeset(params) do
    params = Map.put(params, "event_id", params["event"])
    %Candidate{} |> Candidate.changeset(params)
  end

  defp execute_transaction(changeset, status_id) do
    Multi.new
    |> Multi.insert(:candidate, changeset)
    |> Multi.run(:tracking, &generate_tracking(&1, status_id))
    |> Repo.transaction
  end

  defp generate_tracking(%{candidate: candidate}, status_id) do
    candidate
    |> current_status
    |> find_or_insert_status(candidate, status_id)
  end

  defp find_or_insert_status(nil, candidate, status_id) do
    params = %{candidate_id: candidate.id, status_id: status_id}
    %CandidateStatus{}
    |> CandidateStatus.changeset(params)
    |> Repo.insert
  end
  defp find_or_insert_status(_status, _candidate, nil), do: {:error, %{}}

  defp find_or_insert_status(current_status, candidate, status_id) do
    cond do
      current_status.status_id == status_id -> {:ok, current_status}
      true -> find_or_insert_status(nil, candidate, status_id)
    end
  end

  defp map_current_status(candidate) do
    status = candidate
    |> current_status
    |> Repo.preload(:status)
    |> Map.get(:status)

    %{candidate | status: status}
  end

  defp current_status(candidate) do
    CandidateStatus
    |> last(:inserted_at)
    |> Repo.get_by(candidate_id: candidate.id)
  end

  defp fetch_candidates(model) do
    model
    |> assoc(:candidates)
    |> order_by(:id)
    |> Repo.all
    |> Enum.map(&map_current_status/1)
  end


end
