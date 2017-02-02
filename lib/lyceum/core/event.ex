defmodule Lyceum.Core.Event do

  alias Lyceum.{Repo, Event}

  def list, do: Event |> Repo.all

  def show_info(%{"id" => id}) do
    case Repo.get(Event, id) do
      nil -> {:error, :not_found}
      event -> {:ok, event}
    end
  end

  def create(params) do
    params = params
             |> Map.put("type_id", params["type"])
             |> Map.put("campus_id", params["campus"])
    %Event{}
    |> Event.changeset(params)
    |> Repo.insert
  end

end
