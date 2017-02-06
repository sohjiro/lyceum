defmodule Lyceum.Repo.Migrations.CreateRecordStatus do
  use Ecto.Migration

  def change do
    create table(:records_statuses) do
      add :status_id, references(:statuses, on_delete: :nothing)
      add :record_id, references(:records, on_delete: :nothing)

      timestamps()
    end
    create index(:records_statuses, [:status_id])
    create index(:records_statuses, [:record_id])

  end
end
