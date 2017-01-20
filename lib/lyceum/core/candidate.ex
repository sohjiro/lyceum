defmodule Lyceum.Core.Candidate do
  import Ecto
  alias Lyceum.{Repo, Candidate, Event}

  def create(event_id, params) do
    Event
    |> Repo.get(event_id)
    |> build_assoc(:candidates)
    |> Candidate.changeset(params)
    |> Repo.insert
  end

end
