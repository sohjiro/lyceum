defmodule Lyceum.Core.Mail do
  import Ecto.Query
  alias Ecto.Multi
  alias Lyceum.{Repo, Candidate, Mail}
  @bcc Application.get_env(:lyceum, :bcc)

  def send_mail_flow(params) do
    with {:ok, %{update: mail}} <- insert_email(params) do
      {:ok, Repo.preload(mail, :to)}
    end
  end

  defp insert_email(params) do
    mail_changeset = params |> prepare_changeset

    Multi.new
    |> Multi.insert(:mail, mail_changeset)
    |> Multi.run(:update, &insert_to(&1.mail, params["to"]))
    |> Repo.transaction
  end

  defp prepare_changeset(params) do
    %Mail{}
    |> Ecto.Changeset.change(bcc: format_bcc())
    |> Mail.changeset(params)
  end

  defp format_bcc, do: @bcc |> Stream.map(fn({_name, mail}) -> mail end) |> Enum.join(",")

  defp insert_to(mail, to) do
    params = prepare_changeset_mail_candidate(mail, to)

    mail
    |> Repo.preload(:to)
    |> Ecto.Changeset.cast(params, [])
    |> Ecto.Changeset.cast_assoc(:to)
    |> Repo.update
  end

  defp prepare_changeset_mail_candidate(mail, to) do
    mail_candidates = to
    |> split
    |> find_candidates
    |> Enum.map(fn candidate ->
      %{candidate_id: candidate.id, mail_id: mail.id}
    end)

    %{"to" => mail_candidates}
  end

  defp split(ids), do: ids |> String.split(",") |> Enum.map(&to_int/1)

  defp to_int(id) do
    case Integer.parse(id) do
      {value, _} -> value
      :error -> :error
    end
  end

  defp find_candidates(ids), do: Candidate |> where([c], c.id in ^ids) |> Repo.all
end
