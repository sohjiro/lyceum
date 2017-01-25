defmodule Lyceum.Candidate do
  use Lyceum.Web, :model

  schema "candidates" do
    field :name, :string
    field :degree, :string
    field :email, :string
    field :telephone, :string
    field :observations, :string
    belongs_to :event, Lyceum.Event

    many_to_many :statuses, Lyceum.Status, join_through: Lyceum.CandidateStatus

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :degree, :email, :telephone, :observations, :event_id])
    |> validate_required([:name, :email, :event_id])
    |> validate_format(:email, ~r/@/)
  end
end
