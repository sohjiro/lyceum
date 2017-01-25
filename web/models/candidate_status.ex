defmodule Lyceum.CandidateStatus do
  use Lyceum.Web, :model

  @primary_key: false
  schema "candidates_statuses" do
    belongs_to :candidate, Lyceum.Candidate, primary_key: true
    belongs_to :status, Lyceum.Status, primary_key: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:candidate_id, :status_id])
    |> validate_required([:candidate_id, :status_id])
  end
end
