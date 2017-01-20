defmodule Lyceum.Core.CandidateTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Candidate

  describe "Candidate flow" do
    test "should add a candidate to an event" do
      params = %{
        name: "Name lastname",
        degree: "Student",
        email: "name_lastname@domain.com",
        telephone: "1234567890"
        observations: "This user has some observations"
        event_id: 1
      }

      {:ok, candidate} = Candidate.create(params)

      assert candidate.id
      assert candidate.name == "Name lastname"
      assert candidate.degree == "Student"
      assert candidate.email == "name_lastname@domain"
      assert candidate.telephone == "1234567890"
      assert candidate.observations == "This user has some observations"
      assert candidate.event_id == 1

    end
  end

end
