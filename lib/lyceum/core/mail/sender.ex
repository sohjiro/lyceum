defmodule Lyceum.Core.Mail.Sender do
  use GenServer

  import Swoosh.Email
  @remitent Application.get_env(:lyceum, :remitent)
  @bcc Application.get_env(:lyceum, :bcc)

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def sender(mail) do
    GenServer.cast(__MODULE__, {:send_mail, mail})
  end

  def handle_cast({:send_mail, mail}, state) do
    for to <- mail.to do
      new()
      |> add_to_from(to)
      |> bcc(@bcc)
      |> from(@remitent)
      |> subject(mail.subject)
      |> html_body(mail.body)
      |> Lyceum.Mailer.deliver
    end
    {:noreply, state}
  end

  defp add_to_from(mail, to), do: mail |> to(format_to(to))
  defp format_to(%{candidate: candidate}), do: {candidate.name, candidate.email}

end
