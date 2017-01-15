defmodule Lyceum.EventController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Event

  def create(conn, %{"event" => event_params}) do
    with {:ok, event} <- Event.create(event_params) do
      conn
      |> put_status(:created)
      |> render("show.json", event: event)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{code: "LYC-0001", message: "Bad parameters"})
    end
  end

end
