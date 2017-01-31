defmodule Lyceum.Repo.Migrations.AddingTypeToEvent do
  use Ecto.Migration

  def change do
    alter table :events do
      remove :type
      add :type_id, references(:types, on_delete: :nothing)
    end
    create index(:events, [:type_id])

  end

end
