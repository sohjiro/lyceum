defmodule Lyceum.Repo.Migrations.CreateCandidateStatus do
  use Ecto.Migration

  def change do
    create table(:candidates_statuses) do
      add :candidate_id, references(:candidates, on_delete: :nothing)
      add :status_id, references(:statuses, on_delete: :nothing)

      timestamps()
    end
    create index(:candidates_statuses, [:candidate_id])
    create index(:candidates_statuses, [:status_id])

  end
end
