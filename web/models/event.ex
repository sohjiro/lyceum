defmodule Lyceum.Event do
  use Lyceum.Web, :model

  schema "events" do
    field :type, :string
    field :name, :string
    field :starting_date, Ecto.Date
    field :campus, :string
    field :quorum, :integer
    field :price, :float

    has_many :candidates, Lyceum.Candidate

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :name, :starting_date, :campus, :quorum, :price])
    |> validate_required([:type, :name, :starting_date, :campus, :quorum, :price])
  end
end
