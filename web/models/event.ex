defmodule Lyceum.Event do
  use Lyceum.Web, :model

  schema "events" do
    field :starting_date, Ecto.Date
    field :quorum, :integer
    field :price, :float

    has_many :records, Lyceum.Tracking
    has_many :candidates, through: [:records, :candidate]

    belongs_to :type, Lyceum.Type
    belongs_to :campus, Lyceum.Campus
    belongs_to :subject, Lyceum.Subject

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    fields = ~w[starting_date quorum price type_id campus_id subject_id]a
    struct
    |> cast(params, fields)
    |> validate_required(fields)
  end
end
