defmodule Lyceum.RecordStatus do
  use Lyceum.Web, :model

  schema "records_statuses" do
    belongs_to :status, Lyceum.Status
    belongs_to :record, Lyceum.Record

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
