defmodule Lyceum.CandidateTest do
  use Lyceum.ModelCase

  alias Lyceum.Candidate

  @valid_attrs %{degree: "some content", email: "some content", name: "some content", observations: "some content", telephone: "some content", event_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Candidate.changeset(%Candidate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Candidate.changeset(%Candidate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
