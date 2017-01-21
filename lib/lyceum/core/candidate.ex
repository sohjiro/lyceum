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

  def create(event_id, params) do
    Event
    |> Repo.get(event_id)
    |> build_assoc(:candidates)
    |> Candidate.changeset(params)
    |> Repo.insert
  end

end
