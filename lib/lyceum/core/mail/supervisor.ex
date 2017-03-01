defmodule Lyceum.Core.Mail.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_args) do
    children = [
      worker(Lyceum.Core.Mail.Sender, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

end
