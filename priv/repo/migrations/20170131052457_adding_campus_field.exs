defmodule Lyceum.Repo.Migrations.AddingCampusField do
  use Ecto.Migration

  def change do
    alter table :events do
      remove :campus
      add :campus_id, references(:campuses, on_delete: :nothing)
    end
    create index(:events, [:campus_id])
  end

end
