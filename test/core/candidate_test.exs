defmodule Lyceum.Core.CandidateTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Candidate

  describe "Candidate flow" do
    test "should create a new candidate" do
      params = %{
        "name" => "Name lastname",
        "degree" => "Student",
        "email" => "name_lastname@domain.com",
        "telephone" => "1234567890"
      }

      {:ok, candidate} = Candidate.create(params)

      assert candidate.id
      assert candidate.name == "Name lastname"
      assert candidate.degree == "Student"
      assert candidate.email == "name_lastname@domain.com"
      assert candidate.telephone == "1234567890"
    end

    test "should list all candidates" do
      %Lyceum.Candidate{} |> Repo.insert!

      candidates = Candidate.list(%{})

      assert length(candidates) > 0
    end

    test "should list all candidates matching a term" do
      %Lyceum.Candidate{name: "Some user"} |> Repo.insert!
      %Lyceum.Candidate{name: "user"} |> Repo.insert!
      %Lyceum.Candidate{name: "none"} |> Repo.insert!

      params = %{"term" => "user"}

      candidates = Candidate.list(params)

      assert length(candidates) == 2
    end

    test "should list all candidates for an specified campus" do
      c1 = %Lyceum.Candidate{name: "Some user"} |> Repo.insert!
      c2 = %Lyceum.Candidate{name: "user"} |> Repo.insert!
      %Lyceum.Candidate{name: "none"} |> Repo.insert!

      event = %Lyceum.Event{campus_id: 1} |> Repo.insert!

      %Lyceum.Record{candidate_id: c1.id, event_id: event.id} |> Repo.insert!
      %Lyceum.Record{candidate_id: c2.id, event_id: event.id} |> Repo.insert!

      params = %{"campus_id" => "1"}

      candidates = Candidate.list(params)

      assert length(candidates) == 2
    end
  end

end
