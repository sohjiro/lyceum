defmodule Lyceum.Repo.Migrations.CreateTracking do
  use Ecto.Migration

  def change do
    create table(:tracking) do
      add :candidate_id, references(:candidates, on_delete: :nothing)
      add :status_id, references(:statuses, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end
    create index(:tracking, [:candidate_id])
    create index(:tracking, [:status_id])
    create index(:tracking, [:event_id])

  end
end
