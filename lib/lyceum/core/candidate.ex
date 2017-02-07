defmodule Lyceum.Core.Candidate do
  alias Lyceum.{Repo, Candidate}

  def list, do: Repo.all(Candidate)

  def create(params) do
    %Candidate{}
    |> Candidate.changeset(params)
    |> Repo.insert
  end

  def show_info(%{"id" => id}) do
    case Repo.get(Candidate, id) do
      nil -> {:error, :not_found}
      candidate -> {:ok, candidate}
    end
  end

end
