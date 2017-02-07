defmodule Lyceum.Repo.Migrations.CreateRecord do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :candidate_id, references(:candidates, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)
      add :observations, :string

      timestamps()
    end
    create index(:records, [:candidate_id])
    create index(:records, [:event_id])

    create unique_index(:records, [:candidate_id, :event_id], name: :candidate_event)

  end
end
