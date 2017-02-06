defmodule Lyceum.Record do
  use Lyceum.Web, :model

  schema "records" do
    belongs_to :candidate, Lyceum.Candidate
    belongs_to :event, Lyceum.Event

    many_to_many :statuses, Lyceum.Status, join_through: Lyceum.TrackingStatus

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
