defmodule Lyceum.Candidate do
  use Lyceum.Web, :model

  schema "candidates" do
    field :name, :string
    field :degree, :string
    field :email, :string
    field :telephone, :string

    has_many :records, Lyceum.Record

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :degree, :email, :telephone])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

end
