defmodule Lyceum.Core.Candidate do
  import Ecto
  alias Lyceum.{Repo, Candidate, Event, CandidateStatus}

  def list_for_event(%{"event_id" => event_id}) do
    with {:ok, event} <- Lyceum.Core.Event.show_info(%{"id" => event_id}) do
      event
      |> assoc(:candidates)
      |> Repo.all
    else
      _ -> []
    end
  end

  def show_info(%{"id" => id}) do
    case Repo.get(Candidate, id) do
      nil -> {:error, :not_found}
      candidate -> {:ok, candidate}
    end
  end

  def update(%{"id" => id, "candidate" => params}) do
    Candidate
    |> Repo.get(id)
    |> Candidate.changeset(params)
    |> Repo.update
  end

  def create(params) do
    result = Event
    |> Repo.get(params["event"])
    |> build_assoc(:candidates)
    |> Candidate.changeset(params)
    |> Repo.insert

    with {:ok, candidate} <- result,
         {:ok, _register} <- generate_tracking(candidate, params) do
      {:ok, Repo.preload(candidate, :statuses)}
    end

  end

  defp generate_tracking(candidate, params) do
    %CandidateStatus{}
    |> CandidateStatus.changeset(%{candidate_id: candidate.id, status_id: params["status_id"]})
    |> Repo.insert
  end

end
