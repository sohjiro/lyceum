defmodule Lyceum.RecordTest do
  use Lyceum.ModelCase

  alias Lyceum.Record

  @valid_attrs %{candidate_id: 1, event_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Record.changeset(%Record{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Record.changeset(%Record{}, @invalid_attrs)
    refute changeset.valid?
  end
end
