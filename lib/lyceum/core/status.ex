defmodule Lyceum.Core.Status do

  alias Lyceum.{Repo, Status}

  def list, do: Status |> Repo.all

end
