defmodule Lyceum.TrackingTest do
  use Lyceum.ModelCase

  alias Lyceum.Tracking

  @valid_attrs %{candidate_id: 1, status_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tracking.changeset(%Tracking{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tracking.changeset(%Tracking{}, @invalid_attrs)
    refute changeset.valid?
  end
end
