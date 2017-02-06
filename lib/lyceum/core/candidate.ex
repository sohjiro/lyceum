defmodule Lyceum.Core.Candidate do
  import Ecto
  import Ecto.Query
  alias Ecto.Multi
  alias Lyceum.{Repo, Candidate, Record}

  def list(%{"event_id" => event_id}) do
    with {:ok, event} <- Lyceum.Core.Event.show_info(%{"id" => event_id}) do
      event |> fetch_candidates |> Enum.map(&current_status(&1, event_id))
    else
      _ -> []
    end
  end

  def list(%{"campus_id" => campus_id}) do
    with {:ok, campus} <- Lyceum.Core.Campus.get(%{"id" => campus_id}) do
      campus
      |> assoc(:events)
      |> Repo.all
      |> Enum.map(fn(event) ->
        event
        |> fetch_candidates
        |> Enum.map(&current_status(&1, event.id))
      end)
      |> List.flatten
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
      candidate = current_status(candidate, params["event"])
      {:ok, candidate}
    else
      _ ->
        %{status: :bad_request, code: "LYC-0002", message: "Bad parameters"}
    end
  end

  def update(%{"id" => id, "candidate" => params}) do
    with {:ok, %{candidate: candidate}} <- do_update(id, params) do
      candidate = current_status(candidate, params["event"])
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
    %Record{}
    |> Record.changeset(%{candidate_id: candidate.id, status_id: status_id, event_id: event_id})
    |> Repo.insert
  end

  defp fetch_candidates(model) do
    model
    |> assoc(:candidates)
    |> order_by(:id)
    |> preload(:records)
    |> Repo.all
  end

  defp current_status(candidate, event_id) do
    current_tracking = last_tracking(candidate.id, event_id)
    %{candidate | status: current_tracking.status}
  end

  defp last_tracking(candidate_id, event_id) do
    from(t in Record, where: t.candidate_id == ^candidate_id and t.event_id == ^event_id)
    |> last(:inserted_at)
    |> preload(:status)
    |> Repo.one
  end

end
