defmodule Lyceum.Repo.Migrations.CreateCandidate do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string
      add :degree, :string
      add :email, :string
      add :telephone, :string

      timestamps()
    end
    create unique_index(:candidates, [:email])

  end
end
