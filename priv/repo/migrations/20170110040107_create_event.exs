defmodule Lyceum.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :type, :string
      add :name, :string
      add :starting_date, :date
      add :campus, :string
      add :quorum, :integer
      add :price, :float

      timestamps()
    end

  end
end
