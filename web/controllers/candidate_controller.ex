defmodule Lyceum.CandidateController do
  use Lyceum.Web, :controller

  alias Lyceum.Core.Candidate

  def index(conn, params) do
    render(conn, "index.json", candidates: Candidate.list())
  end

end
