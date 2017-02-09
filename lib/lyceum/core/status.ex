defmodule Lyceum.Core.Status do

  alias Lyceum.{Repo, Status}
  import Ecto.Query, only: [order_by: 2]

  def list, do: Status |> order_by(:id) |> Repo.all

  def get(%{"id" => id}) do
    case Repo.get(Status, id) do
      nil -> {:error, :not_found}
      status -> {:ok, status}
    end
  end

end
