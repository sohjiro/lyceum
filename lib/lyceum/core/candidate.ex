defmodule Lyceum.Core.Candidate do
  alias Lyceum.{Repo, Candidate}

  def list, do: Repo.all(Candidate)

  def create(params) do
    %Candidate{}
    |> Candidate.changeset(params)
    |> Repo.insert
  end

end
