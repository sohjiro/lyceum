defmodule Lyceum.SubjectTest do
  use Lyceum.ModelCase

  alias Lyceum.Subject

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Subject.changeset(%Subject{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Subject.changeset(%Subject{}, @invalid_attrs)
    refute changeset.valid?
  end
end
