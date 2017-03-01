defmodule Lyceum.MailCandidateTest do
  use Lyceum.ModelCase

  alias Lyceum.MailCandidate

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MailCandidate.changeset(%MailCandidate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MailCandidate.changeset(%MailCandidate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
