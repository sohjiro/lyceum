defmodule Lyceum.Core.EventTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Event

  describe "Create an Event" do
    test "should create a new event" do
      params = %{"type" => "course",
                 "name" => "some course",
                 "starting_date" => "2017-01-14",
                 "campus" => "Chiapas",
                 "quorum" => 10,
                 "price" => 1500.00
                }

      {:ok, event} = Event.create(params)

      assert event.id
      assert event.type == "course"
      assert event.name == "some course"
      assert Ecto.Date.compare(event.starting_date, Ecto.Date.cast!("2017-01-14")) == :eq
      assert event.campus == "Chiapas"
      assert event.quorum == 10
      assert event.price == 1500.00
    end
  end

  describe "List events" do
    test "should display all register of events" do
      %Lyceum.Event{type: "type"} |> Repo.insert!

      assert length(Event.list) == 1
    end
  end

end
