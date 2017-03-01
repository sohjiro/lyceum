defmodule Lyceum.MailController do
  use Lyceum.Web, :controller

  def create(conn, %{"mail" => mail_params}) do
    with {:ok, mail} <- Lyceum.Core.Mail.send_mail_flow(mail_params) do
      render(conn, "show.json", mail: mail)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: %{code: "LYC-0001", message: "Bad parameters"}})
    end
  end

end
