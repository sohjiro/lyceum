defmodule Lyceum.Core.RecordTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Record
  alias Lyceum.{Event, Candidate}

  describe "Record flow" do
    test "Add a record to an event" do
      event = %Event{type_id: 1} |> Repo.insert!
      candidate = %Candidate{name: "Name lastname"} |> Repo.insert!

      params = %{"event" => event.id, "candidate" => candidate.id}

      {:ok, record} = Record.create(params)

      assert record.id
      assert record.candidate_id == candidate.id
      assert record.event_id == event.id
    end

    test "Show records for an event" do
      event = %Event{type_id: 1} |> Repo.insert!
      c1 = %Candidate{name: "Name lastname"} |> Repo.insert!
      c2 = %Candidate{name: "Name lastname"} |> Repo.insert!
      %Lyceum.Record{candidate_id: c1.id, event_id: event.id} |> Repo.insert!
      %Lyceum.Record{candidate_id: c2.id, event_id: event.id} |> Repo.insert!

      params = %{"event_id" => event.id}

      records = Record.list(params)

      assert length(records) == 2
    end
  end
end
