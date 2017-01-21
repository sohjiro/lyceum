defmodule Lyceum.Core.Candidate do
  import Ecto
  alias Lyceum.{Repo, Candidate, Event}

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

  def update(%{"id" => id}, params) do
    Candidate
    |> Repo.get(id)
    |> Candidate.changeset(params)
    |> Repo.update
  end

  def create(params) do
    Event
    |> Repo.get(params["event"])
    |> build_assoc(:candidates)
    |> Candidate.changeset(params)
    |> Repo.insert
  end

end
