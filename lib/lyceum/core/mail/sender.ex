defmodule Lyceum.Core.Mail.Sender do
  import Swoosh.Email
  @remitent Application.get_env(:lyceum, :remitent)
  @bcc Application.get_env(:lyceum, :bcc)

  def sender(mail) do
    for to <- mail.to do
      new()
      |> add_to_from(to)
      |> bcc(@bcc)
      |> from(@remitent)
      |> subject(mail.subject)
      |> html_body(mail.body)
      |> Lyceum.Mailer.deliver
    end
  end

  defp add_to_from(mail, to), do: mail |> to(format_to(to))
  defp format_to(%{candidate: candidate}), do: {candidate.name, candidate.email}

end
