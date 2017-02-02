defmodule Lyceum.CampusTest do
  use Lyceum.ModelCase

  alias Lyceum.Campus

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Campus.changeset(%Campus{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Campus.changeset(%Campus{}, @invalid_attrs)
    refute changeset.valid?
  end
end
