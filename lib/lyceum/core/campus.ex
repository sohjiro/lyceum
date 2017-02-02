defmodule Lyceum.Core.Campus do

  alias Lyceum.{Repo, Campus}

  def list, do: Campus |> Repo.all

  def get(%{"id" => id}) do
    case Repo.get(Campus, id) do
      nil -> {:error, :not_found}
      campus -> {:ok, campus}
    end
  end

end
