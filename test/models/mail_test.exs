defmodule Lyceum.MailTest do
  use Lyceum.ModelCase

  alias Lyceum.Mail

  @valid_attrs %{bcc: "some content", body: "some content", subject: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Mail.changeset(%Mail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Mail.changeset(%Mail{}, @invalid_attrs)
    refute changeset.valid?
  end
end
