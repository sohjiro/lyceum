defmodule Lyceum.Event do
  use Lyceum.Web, :model

  schema "events" do
    field :name, :string
    field :starting_date, Ecto.Date
    field :campus, :string
    field :quorum, :integer
    field :price, :float

    has_many :candidates, Lyceum.Candidate
    belongs_to :type_id, Lyceum.Type

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w[type name starting_date campus quorum price type_id]a)
    |> validate_required(~w[type name starting_date campus quorum price type_id]a)
  end
end
