defmodule Lyceum.Core.RecordTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Record
  alias Lyceum.{Event, Status, Candidate, RecordStatus}

  describe "Record flow" do
    test "Add a record to an event" do
      event = %Event{type_id: 1} |> Repo.insert!
      status = Repo.get_by(Status, name: "INFORM")

      params = %{
        "name" => "Name lastname",
        "degree" => "Student",
        "email" => "name_lastname@domain.com",
        "telephone" => "1234567890",
        "observations" => "This user has some observations",
        "event" => event.id,
        "status" => status.id
      }

      {:ok, record} = Record.create(params)

      assert record.id
      assert record.candidate_id
      assert record.event_id
      assert record.candidate.name == "Name lastname"
      assert record.candidate.degree == "Student"
      assert record.candidate.email == "name_lastname@domain.com"
      assert record.candidate.telephone == "1234567890"
      assert record.candidate.observations == "This user has some observations"
      assert length(record.statuses) == 1
    end

    test "Update status for a record" do
      event = %Event{type_id: 1} |> Repo.insert!
      candidate = %Candidate{name: "Name lastname"} |> Repo.insert!
      status = Repo.get_by(Status, name: "INFORM")
      record = %Lyceum.Record{candidate_id: candidate.id, event_id: event.id} |> Repo.insert!
      %RecordStatus{record_id: record.id, status_id: status.id} |> Repo.insert!

      params = %{"status" => 2}

      {:ok, record} = Record.update(record.id, params)

      assert record.id
      assert record.candidate_id == candidate.id
      assert record.event_id == event.id
      assert length(record.statuses) == 2
    end
  end
end
