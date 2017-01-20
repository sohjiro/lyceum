defmodule Lyceum.Repo.Migrations.CreateCandidate do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string
      add :degree, :string
      add :email, :string
      add :phone, :string
      add :telephone, :string
      add :observations, :string
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end
    create index(:candidates, [:event_id])

  end
end
