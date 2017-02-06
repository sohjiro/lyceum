defmodule Lyceum.RecordStatusTest do
  use Lyceum.ModelCase

  alias Lyceum.RecordStatus

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RecordStatus.changeset(%RecordStatus{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RecordStatus.changeset(%RecordStatus{}, @invalid_attrs)
    refute changeset.valid?
  end
end
