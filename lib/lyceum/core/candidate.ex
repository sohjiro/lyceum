defmodule Lyceum.Core.Candidate do
  import Ecto.Query, only: [from: 2]
  alias Lyceum.{Repo, Candidate}

  def list(%{"term" => term}) do
    term
    |> parse_term
    |> generate_query
    |> find_all
  end
  def list(_params), do: Candidate |> find_all

  def create(params) do
    %Candidate{}
    |> Candidate.changeset(params)
    |> Repo.insert
  end

  def show_info(%{"id" => id}) do
    case Repo.get(Candidate, id) do
      nil -> {:error, :not_found}
      candidate -> {:ok, Repo.preload(candidate, [:records, records: [:event, :statuses] ])}
    end
  end

  defp parse_term(term), do: "%#{term}%"
  defp generate_query(term), do: from(c in Candidate, where: ilike(c.name, ^term))
  defp find_all(query), do: query |> Repo.all

end
