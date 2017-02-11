defmodule Lyceum.Core.RecordStatus do
  import Ecto.Query, only: [order_by: 2]
  alias Lyceum.Core.Record
  alias Lyceum.{Repo, RecordStatus}

  def list(params) do
    with {:ok, record} <- Record.info(params) do
      record |> Ecto.assoc(:statuses) |> order_by(:inserted_at) |> Repo.all
    end
  end

  def create(params) do
    params = parse_params(params)
    current_status = params |> list |> current_status

    case same?(current_status, params) do
      {:same, status} -> {:ok, status}
      {:insert, changeset} -> Repo.insert(changeset)
    end
  end

  defp parse_params(%{"record" => record_id, "status" => status_id}) do
    %{"record_id" => record_id, "status_id" => status_id}
  end

  defp current_status([]), do: nil
  defp current_status([current | _rest]), do: current

  defp same?(%{status_id: status_id, record_id: record_id} = status, params) do
    case status_id == params["status_id"] && record_id == params["record_id"] do
      true -> {:same, status}
      false -> {:insert, prepare_changeset(params)}
    end
  end
  defp same?(nil, params), do: {:insert, prepare_changeset(params)}

  defp prepare_changeset(params) do
    RecordStatus.changeset(%RecordStatus{}, params)
  end

end
