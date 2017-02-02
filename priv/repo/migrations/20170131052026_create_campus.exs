defmodule Lyceum.Repo.Migrations.CreateCampus do
  use Ecto.Migration

  def change do
    create table(:campuses) do
      add :name, :string

      timestamps()
    end

  end
end
