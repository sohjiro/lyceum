defmodule Lyceum.Repo.Migrations.AddingSubjectToEvent do
  use Ecto.Migration

  def change do
    alter table :events do
      remove :name
      add :subject_id, references(:subjects, on_delete: :nothing)
    end
    create index(:events, [:subject_id])
  end
end
