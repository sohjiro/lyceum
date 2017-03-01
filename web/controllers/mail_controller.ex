defmodule Lyceum.MailController do
  use Lyceum.Web, :controller

  def create(conn, %{"mail" => mail_params}) do
    Lyceum.Core.Mail.send_mail_flow(mail_params)

    json(conn, %{message: "Sending email"})
  end

end
