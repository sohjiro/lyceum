defmodule Lyceum.Core.Candidate do
  import Ecto
  import Ecto.Query, only: [last: 2, order_by: 2]
  alias Ecto.Multi
  alias Lyceum.{Repo, Candidate, Tracking}

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
      candidate -> {:ok, Repo.preload(candidate, :records)}
    end
  end

  def create(params) do
    with {:ok, %{candidate: candidate}} <- insert(params) do
      candidate = candidate |> Repo.preload([:records])
      {:ok, candidate}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
    end
  end

  def update(%{"id" => id, "candidate" => params}) do
    with {:ok, %{candidate: candidate}} <- do_update(id, params) do
      candidate = candidate |> Repo.preload([:records])
      {:ok, candidate}
    end
  end

  defp do_update(id, params) do
    changeset = Candidate |> Repo.get(id) |> Candidate.changeset(params)

    Multi.new
    |> Multi.update(:candidate, changeset)
    |> Multi.run(:tracking, &generate_tracking(&1, params["status"], params["event"]))
    |> Repo.transaction
  end

  defp insert(params) do
    %Candidate{}
    |> Candidate.changeset(params)
    |> execute_transaction(params["status"], params["event"])
  end

  defp execute_transaction(changeset, status_id, event_id) do
    Multi.new
    |> Multi.insert(:candidate, changeset)
    |> Multi.run(:tracking, &generate_tracking(&1, status_id, event_id))
    |> Repo.transaction
  end

  defp generate_tracking(%{candidate: candidate}, status_id, event_id) do
    %Tracking{}
    |> Tracking.changeset(%{candidate_id: candidate.id, status_id: status_id, event_id: event_id})
    |> Repo.insert
  end

  defp fetch_candidates(model) do
    model
    |> assoc(:candidates)
    |> order_by(:id)
    |> Repo.all
  end

end
