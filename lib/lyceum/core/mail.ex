defmodule Lyceum.Core.Mail do
  import Ecto.Query
  import Swoosh.Email, except: [from: 2]
  alias Lyceum.{Repo, Candidate, Mail}
  @remitent Application.get_env(:lyceum, :remitent)
  @bcc Application.get_env(:lyceum, :bcc)

  def send_mail(params) do
    %Mail{}
    |> Ecto.Changeset.change(bcc: Enum.join(@bcc, ","))
    |> Mail.changeset(params)
    |> Repo.insert


    # to
    # |> split
    # |> find_candidates
    # |> format_to
    # |> Enum.map(&Task.async(Lyceum.Core.Mail, :do_send_mail, [&1, subject, body]))
    # |> Enum.map(&Task.await(&1))
  end
  def do_send_mail(to, subject, body) do
    to
    |> prepare_mail(subject, body)
    |> Lyceum.Mailer.deliver
  end
  def save_emails(emails, _params) do
    emails
    |> Enum.map(fn({:ok, v}) -> v.id end)
    |> IO.inspect
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

end
