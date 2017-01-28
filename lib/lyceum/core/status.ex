defmodule Lyceum.Core.Status do

  alias Lyceum.{Repo, Status}

  def list, do: Status |> Repo.all

  def get(%{"id" => id}) do
    case Repo.get(Status, id) do
      nil -> {:error, :not_found}
      status -> {:ok, status}
    end
  end

end
