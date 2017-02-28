defmodule Lyceum.Repo.Migrations.CreateMail do
  use Ecto.Migration

  def change do
    create table(:mails) do
      add :subject, :string
      add :bcc, :string
      add :body, :string

      timestamps()
    end

  end
end
