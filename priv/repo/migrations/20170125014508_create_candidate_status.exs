defmodule Lyceum.Repo.Migrations.CreateCandidateStatus do
  use Ecto.Migration

  def change do
    create table(:candidates_statuses, primary_key: false) do
      add :candidate_id, references(:candidates, on_delete: :nothing), primary_key: true
      add :status_id, references(:statuses, on_delete: :nothing), primary_key: true

      timestamps()
    end
    create index(:candidates_statuses, [:candidate_id])
    create index(:candidates_statuses, [:status_id])

  end
end
