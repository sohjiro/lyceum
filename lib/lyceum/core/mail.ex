defmodule Lyceum.Core.Mail do
  import Ecto.Query
  import Swoosh.Email, except: [from: 2]
  alias Lyceum.{Repo, Candidate}

  def send_mail(%{"mail" => params}) do
    new()
    |> add_to(params)
    |> Swoosh.Email.from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject(params["subject"])
    |> html_body(params["body"])
    |> text_body("some text")
    |> Lyceum.Mailer.deliver
  end

  defp add_to(email, %{"to" => ids}) do
    ids
    |> split
    |> find_candidates
    |> format_to
    |> add_to_mail(email)
  end

  defp split(ids), do: ids |> String.split(",")
  defp find_candidates(ids), do: Candidate |> where([c], c.id in ^ids) |> Repo.all
  defp format_to(candidates), do: candidates |> Enum.map(&info_candidate/1)
  defp info_candidate(candidate), do: {candidate.name, candidate.email}
  defp add_to_mail(data_mails, email), do: email |> to(data_mails)

end
