defmodule Lyceum.Core.CandidateTest do
  use Lyceum.ModelCase

  alias Lyceum.{Event, Status}
  alias Lyceum.Core.Candidate

  describe "Candidate flow" do
    test "should add a candidate to an event" do
      event = %Event{type_id: 1} |> Repo.insert!
      status = Repo.insert!(%Status{name: "INFORM"})

      params = %{
        "name" => "Name lastname",
        "degree" => "Student",
        "email" => "name_lastname@domain.com",
        "telephone" => "1234567890",
        "observations" => "This user has some observations",
        "status" => status.id,
        "event" => event.id
      }

      {:ok, candidate} = Candidate.create(params)

      assert candidate.id
      assert candidate.name == "Name lastname"
      assert candidate.degree == "Student"
      assert candidate.email == "name_lastname@domain.com"
      assert candidate.telephone == "1234567890"
      assert candidate.observations == "This user has some observations"
      assert length(candidate.statuses) == 1
      assert length(candidate.events) == 1
    end

  end

end
