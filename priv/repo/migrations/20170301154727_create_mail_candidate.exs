defmodule Lyceum.Repo.Migrations.CreateMailCandidate do
  use Ecto.Migration

  def change do
    create table(:mails_candidates) do
      add :mail_id, references(:mails, on_delete: :nothing)
      add :candidate_id, references(:candidates, on_delete: :nothing)

      timestamps()
    end
    create index(:mails_candidates, [:mail_id])
    create index(:mails_candidates, [:candidate_id])

  end
end
