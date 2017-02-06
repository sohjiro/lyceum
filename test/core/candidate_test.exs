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
      assert length(candidate.records) == 1
    end

    test "should list all for a campus and event" do
      event = %Event{campus_id: 3} |> Repo.insert!
      c1 = %Lyceum.Candidate{name: "Name 1"} |> Repo.insert!
      c2 = %Lyceum.Candidate{name: "Name 2"} |> Repo.insert!
      c3 = %Lyceum.Candidate{name: "Name 3"} |> Repo.insert!
      %Lyceum.Tracking{candidate_id: c1.id, status_id: 1, event_id: event.id} |> Repo.insert!
      %Lyceum.Tracking{candidate_id: c2.id, status_id: 1, event_id: event.id} |> Repo.insert!
      %Lyceum.Tracking{candidate_id: c3.id, status_id: 1, event_id: event.id} |> Repo.insert!

      candidates = Candidate.list(%{"campus_id" => 3})
      assert length(candidates) == 3

      candidates = Candidate.list(%{"campus_id" => 1})
      assert length(candidates) == 0

      candidates = Candidate.list(%{"event_id" => event.id})
      assert length(candidates) == 3
    end

    test "should show info for a specific candidate" do
      event = %Event{type_id: 1} |> Repo.insert!
      candidate = %Lyceum.Candidate{name: "Name lastname", degree: "Student", email: "name_lastname@domain.com", telephone: "1234567890", observations: "This user has some observations"} |> Repo.insert!
      %Lyceum.Tracking{candidate_id: candidate.id, status_id: 1, event_id: event.id} |> Repo.insert!
      %Lyceum.Tracking{candidate_id: candidate.id, status_id: 2, event_id: event.id} |> Repo.insert!

      {:ok, data} = Candidate.show_info(%{"id" => candidate.id})

      assert data.name == "Name lastname"
      assert data.degree == "Student"
      assert data.email == "name_lastname@domain.com"
      assert data.telephone == "1234567890"
      assert data.observations == "This user has some observations"
      assert length(data.records) == 2
    end

    test "should update info for a specific candidate" do
      event = %Event{type_id: 1} |> Repo.insert!
      candidate = %Lyceum.Candidate{name: "Name lastname", degree: "Student", email: "name_lastname@domain.com", telephone: "1234567890", observations: "This user has some observations"} |> Repo.insert!
      %Lyceum.Tracking{candidate_id: candidate.id, status_id: 1, event_id: event.id} |> Repo.insert!

      params = %{
        "name" => "name",
        "degree" => "degree",
        "email" => "email@domain.com",
        "telephone" => "9090909090",
        "observations" => "observations",
        "status" => 2,
        "event" => event.id
      }

      {:ok, data} = Candidate.update(%{"id" => candidate.id, "candidate" => params})

      assert data.name == "name"
      assert data.degree == "degree"
      assert data.email == "email@domain.com"
      assert data.telephone == "9090909090"
      assert data.observations == "observations"
      assert length(data.records) == 2
      assert data.status.id == 2
      assert data.status.name == "INTERESTED"
    end

    test "should reject a candidate creation" do
      event = %Event{type_id: 1} |> Repo.insert!

      params = %{
        "name" => "Name lastname",
        "degree" => "Student",
        "email" => "name_lastname@domain.com",
        "telephone" => "1234567890",
        "observations" => "This user has some observations",
        "event" => event.id
      }

      response = Candidate.create(params)

      assert response.status == :bad_request
      assert response.code == "LYC-0002"
      assert response.message == "Bad parameters"
    end

  end

end
