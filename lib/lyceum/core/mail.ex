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
    |> format
    |> mail_add_to(email)
  end

  defp split(ids), do: ids |> String.split(",")
  defp find_candidates(ids) do
    from(c in Candidate, where: c.id in ^ids) |> Repo.all
  end

  defp format(candidates), do: candidates |> Enum.map(fn(c) -> {c.name, c.email} end)
  defp mail_add_to(data_mails, email), do: email |> to(data_mails)

end
