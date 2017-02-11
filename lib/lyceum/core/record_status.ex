defmodule Lyceum.Core.RecordStatus do
  import Ecto.Query, only: [order_by: 2]
  alias Lyceum.Core.Record
  alias Lyceum.{Repo, RecordStatus}

  def list(params) do
    with {:ok, record} <- Record.info(params) do
      record |> Ecto.assoc(:statuses) |> order_by(desc: :inserted_at) |> Repo.all
    end
  end

  def create(params) do
    params = params |> parse_params

    params
    |> list
    |> current_status
    |> handle_record(params)
  end

  defp parse_params(%{"record" => record_id, "status" => status_id}) do
    %{"record_id" => to_int(record_id), "status_id" => to_int(status_id)}
  end

  defp current_status([]), do: nil
  defp current_status([current | _rest]), do: current

  defp handle_record(%{status_id: status_id, record_id: record_id} = status, params) do
    case status_id == params["status_id"] && record_id == params["record_id"] do
      true -> {:ok, status}
      false -> insert_record(params)
    end
  end
  defp handle_record(nil, params), do: params |> insert_record

  defp insert_record(params) do
    %RecordStatus{}
    |> RecordStatus.changeset(params)
    |> Repo.insert
  end

  defp to_int(value) when is_integer(value), do: value
  defp to_int(value) when is_bitstring(value) do
    case Integer.parse(value) do
      {integer, _} -> integer
      :error -> :error
    end
  end

end
