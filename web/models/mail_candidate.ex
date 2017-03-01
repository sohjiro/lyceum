defmodule Lyceum.MailCandidate do
  use Lyceum.Web, :model

  schema "mails_candidates" do
    belongs_to :mail, Lyceum.Mail
    belongs_to :candidate, Lyceum.Candidate

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:mail_id, :candidate_id])
    |> validate_required([:mail_id, :candidate_id])
  end
end
