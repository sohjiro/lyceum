defmodule Lyceum.Core.RecordTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Record
  alias Lyceum.{Event, Status}

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
  end
end
