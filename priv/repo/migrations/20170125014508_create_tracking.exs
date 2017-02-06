defmodule Lyceum.Repo.Migrations.CreateTracking do
  use Ecto.Migration

  def change do
    create table(:tracking) do
      add :candidate_id, references(:candidates, on_delete: :nothing)
      add :status_id, references(:statuses, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end
    create index(:candidates_statuses, [:candidate_id])
    create index(:candidates_statuses, [:status_id])
    create index(:candidates_statuses, [:event_id])

  end
end
