defmodule Lyceum.Tracking do
  use Lyceum.Web, :model

    belongs_to :candidate, Lyceum.Candidate
    belongs_to :status, Lyceum.Status
    belongs_to :event, Lyceum.Event

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:candidate_id, :status_id, :event_id])
    |> validate_required([:candidate_id, :status_id, :event_id])
  end
end
