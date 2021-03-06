defmodule Lyceum.EventController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Event

  def index(conn, _params) do
    render(conn, "index.json", events: Event.list())
  end

  def show(conn, params) do
    with {:ok, event} <- Event.show_info(params) do
      render(conn, "show.json", event: event)
    end
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, event} <- Event.create(event_params) do
      conn
      |> put_status(:created)
      |> render("show.json", event: event)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

end
