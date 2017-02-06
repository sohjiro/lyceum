defmodule Lyceum.CandidateView do
  use Lyceum.Web, :view

  def render("index.json", %{candidates: candidates}) do
    %{candidates: render_many(candidates, Lyceum.CandidateView, "candidate.json")}
  end

  def render("show.json", %{candidate: candidate}) do
    %{candidate: render_one(candidate, Lyceum.CandidateView, "candidate.json")}
  end

  def render("candidate.json", %{candidate: candidate}) do
    %{
      id: candidate.id,
      name: candidate.name,
      degree: candidate.degree,
      email: candidate.email,
      telephone: candidate.telephone,
      observations: candidate.observations,
      status: candidate.status.id
    }
  end

end
