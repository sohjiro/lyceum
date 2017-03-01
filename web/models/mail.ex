defmodule Lyceum.Mail do
  use Lyceum.Web, :model

  schema "mails" do
    field :subject, :string
    field :bcc, :string
    field :body, :string

    has_many :to, Lyceum.MailCandidate

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:subject, :bcc, :body])
    |> validate_required([:subject, :bcc, :body])
  end
end
