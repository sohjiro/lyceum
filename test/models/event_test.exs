defmodule Lyceum.EventTest do
  use Lyceum.ModelCase

  alias Lyceum.Event

  @valid_attrs %{campus_id: 1, name: "some content", price: "120.5", quorum: 42, starting_date: %{day: 17, month: 4, year: 2010}, type_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
