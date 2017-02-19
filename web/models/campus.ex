defmodule Lyceum.Campus do
  use Lyceum.Web, :model

  schema "campuses" do
    field :name, :string

    has_many :events, Lyceum.Event
    has_many :candidates, through: [:events, :records, :candidate]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
