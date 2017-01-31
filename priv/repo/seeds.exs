# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lyceum.Repo.insert!(%Lyceum.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Lyceum.{Repo, Status, Type}

for status <- ~w[INFORM INTERESTED TENTATIVE ENROLLED DECLINE] do
  Repo.get_by(Status, name: status) || Repo.insert!(%Status{name: status})
end

for type <- ~w[CERTIFIED COURSE WORKSHOP] do
    Repo.get_by(Type, name: type) || Repo.insert!(%Type{name: type})
end
