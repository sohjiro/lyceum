defmodule Lyceum.Core.Candidate do
  import Ecto
  import Ecto.Query, only: [last: 2]
  alias Ecto.Multi
  alias Lyceum.{Repo, Candidate, CandidateStatus}

  def list_for_event(%{"event_id" => event_id}) do
    with {:ok, event} <- Lyceum.Core.Event.show_info(%{"id" => event_id}) do
      event
      |> assoc(:candidates)
      |> Repo.all
      # |> Repo.preload(:statuses)
      # |> Enum.map(fn(candidate) ->
      #   current_status = Lyceum.Candidate.current_status(candidate)
      #   %{candidate | current_status: current_status}
      # end)
    else
      _ -> []
    end
  end

  def show_info(%{"id" => id}) do
    case Repo.get(Candidate, id) do
      nil -> {:error, :not_found}
      candidate -> candidate |> map_current_status
    end
  end

  def update(%{"id" => id, "candidate" => params}) do
    Candidate
    |> Repo.get(id)
    |> Candidate.changeset(params)
    |> Repo.update
  end

  def create(params) do
    with {:ok, %{candidate: candidate}} <- insert(params) do
      {:ok, Repo.preload(candidate, :statuses)}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
    end
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
    %CandidateStatus{}
    |> CandidateStatus.changeset(%{candidate_id: candidate.id, status_id: status_id})
    |> Repo.insert
  end

  defp map_current_status(candidate) do
    status = CandidateStatus
    |> last(:inserted_at)
    |> Repo.get_by(candidate_id: candidate.id)
    |> Repo.preload(:status)
    |> Map.get(:status)

    {:ok, %{candidate | statuses: [status]}}
  end

end
