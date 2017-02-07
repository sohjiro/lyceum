defmodule Lyceum.Core.Candidate do
  alias Lyceum.{Repo, Candidate}

  def list, do: Repo.all(Candidate)

end
