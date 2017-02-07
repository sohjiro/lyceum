defmodule Lyceum.Core.RecordTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Record
  alias Lyceum.{Event, Status, Candidate, RecordStatus}

  describe "Record flow" do
    test "Add a record to an event" do
      event = %Event{type_id: 1} |> Repo.insert!
      candidate = %Candidate{name: "Name lastname"} |> Repo.insert!
      status = Repo.get_by(Status, name: "INFORM")

      params = %{"event" => event.id,
                 "candidate" => candidate.id,
                 "status" => status.id
                }

      {:ok, record} = Record.create(params)

      assert record.id
      assert record.candidate_id == candidate.id
      assert record.event_id == event.id
      assert length(record.statuses) == 1
    end

    test "Update status for a record" do
      event = %Event{type_id: 1} |> Repo.insert!
      candidate = %Candidate{name: "Name lastname"} |> Repo.insert!
      status = Repo.get_by(Status, name: "INFORM")
      record = %Lyceum.Record{candidate_id: candidate.id, event_id: event.id} |> Repo.insert!
      %RecordStatus{record_id: record.id, status_id: status.id} |> Repo.insert!

      params = %{"status" => 2, "id" => record.id}

      {:ok, record} = Record.update(params)

      assert record.id
      assert record.candidate_id == candidate.id
      assert record.event_id == event.id
      assert length(record.statuses) == 2
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
