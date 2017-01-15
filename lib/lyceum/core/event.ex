defmodule Lyceum.Core.Event do

  alias Lyceum.{Repo, Event}

  def create(params) do
    %Event{}
    |> Event.changeset(params)
    |> Repo.insert
  end

end
