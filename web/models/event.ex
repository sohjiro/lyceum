defmodule Lyceum.Event do
  use Lyceum.Web, :model

  schema "events" do
    field :name, :string
    field :starting_date, Ecto.Date
    field :quorum, :integer
    field :price, :float

    has_many :candidates, Lyceum.Candidate
    belongs_to :type, Lyceum.Type
    belongs_to :campus, Lyceum.Campus

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    opts = ~w[name starting_date campus quorum price type_id campus_id]a
    struct
    |> cast(params, opts)
    |> validate_required(opts)
  end
end
