defmodule Lyceum.RecordController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Record

  def index(conn, params) do
    render(conn, "index.json", records: Record.list(params))
  end

  def show(conn, %{"id" => id}) do
    with {:ok, record} <- Record.info(%{"record_id" => id}) do
      render(conn, "show.json", record: record)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

  def create(conn, %{"record" => params}) do
    with {:ok, record} <- Record.create(params) do
      conn
      |> put_status(:created)
      |> render("show.json", record: record)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

  def update(conn, %{"id" => id, "record" => params}) do
    with {:ok, record} <- Record.update(id, params) do
      conn
      |> put_status(:accepted)
      |> render("show.json", record: record)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

end
