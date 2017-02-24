defmodule Lyceum.Core.Mail do
  import Ecto.Query
  import Swoosh.Email, except: [from: 2]
  alias Lyceum.{Repo, Candidate}
  @remitent Application.get_env(:lyceum, :remitent)
  @bcc Application.get_env(:lyceum, :bcc)

  def send_mail(%{"to" => to, "subject" => subject, "body" => body}) do
    to
    |> split
    |> find_candidates
    |> format_to
    |> Enum.map(&prepare_mail(&1, subject, body))
    |> Enum.map(fn(mail) -> Lyceum.Mailer.deliver(mail) end)
  end

  defp prepare_mail(to, subject, body) do
    new()
    |> to(to)
    |> bcc(@bcc)
    |> Swoosh.Email.from(@remitent)
    |> subject(subject)
    |> html_body(body)
  end

  defp split(ids), do: ids |> String.split(",") |> Enum.map(&to_int/1)

  defp to_int(id) do
    case Integer.parse(id) do
      {value, _} -> value
      :error -> :error
    end
  end

  defp find_candidates(ids), do: Candidate |> where([c], c.id in ^ids) |> Repo.all
  defp format_to(candidates), do: candidates |> Enum.map(&info_candidate/1)
  defp info_candidate(candidate), do: {candidate.name, candidate.email}
  defp add_to_mail(data_mails, email), do: email |> to(data_mails)

end
