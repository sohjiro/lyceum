defmodule Lyceum.Core.CandidateTest do
  use Lyceum.ModelCase

  alias Lyceum.Event
  alias Lyceum.Core.Candidate

  describe "Candidate flow" do
    test "should add a candidate to an event" do
      event = %Event{type: "Course"} |> Repo.insert!

      params = %{
        "name" => "Name lastname",
        "degree" => "Student",
        "email" => "name_lastname@domain.com",
        "telephone" => "1234567890",
        "observations" => "This user has some observations",
        "event" => event.id
      }

      {:ok, candidate} = Candidate.create(params)

      assert candidate.id
      assert candidate.name == "Name lastname"
      assert candidate.degree == "Student"
      assert candidate.email == "name_lastname@domain.com"
      assert candidate.telephone == "1234567890"
      assert candidate.observations == "This user has some observations"
      assert candidate.event_id == event.id
    end

    test "should list all candidates for an event" do
      event = %Event{type: "Course"} |> Repo.insert!
      %Lyceum.Candidate{name: "Name 1", event_id: event.id} |> Repo.insert!
      %Lyceum.Candidate{name: "Name 2", event_id: event.id} |> Repo.insert!
      %Lyceum.Candidate{name: "Name 3", event_id: event.id} |> Repo.insert!

      candidates = Candidate.list_for_event(%{"event_id" => event.id})

      assert length(candidates) == 3
    end

    test "should show info for a specific candidate" do
      event = %Event{type: "Course"} |> Repo.insert!
      candidate = %Lyceum.Candidate{name: "Name lastname", degree: "Student", email: "name_lastname@domain.com", telephone: "1234567890", observations: "This user has some observations", event_id: event.id} |> Repo.insert!

      {:ok, data} = Candidate.show_info(%{"id" => candidate.id})

      assert data.name == "Name lastname"
      assert data.degree == "Student"
      assert data.email == "name_lastname@domain.com"
      assert data.telephone == "1234567890"
      assert data.observations == "This user has some observations"
      assert data.event_id == event.id
    end

    test "should update info for a specific candidate" do
      event = %Event{type: "Course"} |> Repo.insert!
      candidate = %Lyceum.Candidate{name: "Name lastname", degree: "Student", email: "name_lastname@domain.com", telephone: "1234567890", observations: "This user has some observations", event_id: event.id} |> Repo.insert!

      params = %{
        "name" => "name",
        "degree" => "degree",
        "email" => "email@domain.com",
        "telephone" => "9090909090",
        "observations" => "observations"
      }

      {:ok, data} = Candidate.update(%{"id" => candidate.id}, params)

      assert data.name == "name"
      assert data.degree == "degree"
      assert data.email == "email@domain.com"
      assert data.telephone == "9090909090"
      assert data.observations == "observations"
      assert data.event_id == event.id
    end
  end

end
