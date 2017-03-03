defmodule Lyceum.MailView do
  use Lyceum.Web, :view

  def render("show.json", %{mail: mail}) do
    %{mail: render_one(mail, Lyceum.MailView, "mail.json")}
  end

  def render("mail.json", %{mail: mail}) do
    %{
      id: mail.id,
      subject: mail.subject,
      bcc: mail.bcc,
      body: mail.body,
      to: Enum.map(mail.candidates, &(&1.email))
    }
  end

end
