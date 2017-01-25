defmodule Lyceum.CandidateStatusTest do
  use Lyceum.ModelCase

  alias Lyceum.CandidateStatus

  @valid_attrs %{candidate_id: 1, status_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CandidateStatus.changeset(%CandidateStatus{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CandidateStatus.changeset(%CandidateStatus{}, @invalid_attrs)
    refute changeset.valid?
  end
end
