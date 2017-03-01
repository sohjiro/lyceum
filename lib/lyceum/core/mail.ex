defmodule Lyceum.Core.Mail do
  import Ecto.Query
  alias Ecto.Multi
  import Swoosh.Email, except: [from: 2]
  alias Lyceum.{Repo, Candidate, Mail}
  @remitent Application.get_env(:lyceum, :remitent)
  @bcc Application.get_env(:lyceum, :bcc)

  def send_mail_flow(params) do
    with {:ok, %{mail: mail}} <- insert_email(params) do
      {:ok, mail}
    end
  end

  defp insert_email(params) do
    mail_changeset = params |> prepare_changeset

    Multi.new
    |> Multi.insert(:mail, mail_changeset)
    |> Repo.transaction
  end

  defp prepare_changeset(params) do
    %Mail{}
    |> Ecto.Changeset.change(bcc: format_bcc)
    |> Mail.changeset(params)
  end

  defp format_bcc, do: @bcc |> Stream.map(fn({_name, mail}) -> mail end) |> Enum.join(",")

  defp insert_mail(changeset), do: changeset |> Repo.insert

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

    %{"mail_candidates" => mail_candidates}

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
