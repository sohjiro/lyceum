defmodule Lyceum.Record do
  use Lyceum.Web, :model

  schema "records" do
    belongs_to :candidate, Lyceum.Candidate
    belongs_to :event, Lyceum.Event
    field :observations, :string

    has_many :statuses, Lyceum.RecordStatus

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:candidate_id, :event_id, :observations])
    |> validate_required([:candidate_id, :event_id])
    |> unique_constraint(:candidate_id, name: :candidate_event)
  end

end
