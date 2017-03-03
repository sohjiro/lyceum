defmodule Lyceum.Core.Mail do
  import Ecto.Query
  alias Ecto.Multi
  alias Lyceum.{Repo, Candidate, Mail}
  @bcc Application.get_env(:lyceum, :bcc)

  def send_mail_flow(params) do
    with {:ok, %{update: mail}} <- email_flow(params) do
      mail = Repo.preload(mail, [:candidates])
      Lyceum.Core.Mail.Sender.sender(mail)
      {:ok, mail}
    else
      _error -> {:error, :bad_request}
    end
  end

  defp email_flow(params) do
    params
    |> parse_to
    |> find_candidates
    |> insert_email(params)
  end

  defp parse_to(%{"to" => to}), do: to |> String.split(",") |> Enum.map(&to_int/1)

  defp to_int(id) do
    case Integer.parse(id) do
      {value, _} -> value
      :error -> :error
    end
  end

  defp find_candidates(ids) do
    case :error in ids do
      true -> :error
      _ -> Candidate |> where([c], c.id in ^ids) |> Repo.all
    end
  end

  defp insert_email(to, params) when is_list(to) do
    mail_changeset = params |> prepare_changeset

    Multi.new
    |> Multi.insert(:mail, mail_changeset)
    |> Multi.run(:update, &insert_to(&1.mail, to))
    |> Repo.transaction
  end
  defp insert_email(_others, _params), do: {:error, :bad_request}

  defp prepare_changeset(params) do
    %Mail{}
    |> Ecto.Changeset.change(bcc: format_bcc())
    |> Mail.changeset(params)
  end

  defp format_bcc, do: @bcc |> Stream.map(fn({_name, mail}) -> mail end) |> Enum.join(",")

  defp insert_to(mail, to) do
    params = format_mail_candidate(mail, to)

    mail
    |> Repo.preload(:to)
    |> Ecto.Changeset.cast(params, [])
    |> Ecto.Changeset.cast_assoc(:to)
    |> Repo.update
  end

  defp format_mail_candidate(mail, candidates) do
    candidates
    |> Enum.reduce(%{to: []}, fn(candidate, acc) ->
      candidate
      |> map_mail_candidate(mail)
      |> format_response(acc)
    end)
  end

  defp map_mail_candidate(candidate, mail), do: %{candidate_id: candidate.id, mail_id: mail.id}
  defp format_response(mail_candidate, acc), do: %{to: [mail_candidate | acc.to]}


end
