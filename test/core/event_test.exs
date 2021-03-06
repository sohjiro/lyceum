defmodule Lyceum.Core.EventTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Event

  describe "Create an Event" do
    test "should create a new event" do
      params = %{"type" => 1,
                 "starting_date" => "2017-01-14",
                 "campus" => 1,
                 "quorum" => 10,
                 "price" => 1500.00,
                 "subject" => 2
                }

      {:ok, event} = Event.create(params)

      assert event.id
      assert event.type_id == 1
      assert event.subject_id == 2
      assert Ecto.Date.compare(event.starting_date, Ecto.Date.cast!("2017-01-14")) == :eq
      assert event.campus_id == 1
      assert event.quorum == 10
      assert event.price == 1500.00
    end
  end

  describe "List events" do
    test "should display all register of events" do
      %Lyceum.Event{type_id: 1} |> Repo.insert!

      assert length(Event.list) == 1
    end
  end

  describe "Display event information" do
    test "should display data about an alreday created event" do
      e = %Lyceum.Event{type_id: 1} |> Repo.insert!

      {:ok, event} = Event.show_info(%{"id" => e.id})

      assert event.id == e.id
      assert event.type_id == 1
    end
  end

end
