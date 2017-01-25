defmodule Lyceum.StatusView do
  use Lyceum.Web, :view

  def render("index.json", %{statuses: statuses}) do
    %{statuses: render_many(statuses, Lyceum.StatusView, "status.json")}
  end

  def render("status.json", %{status: status}) do
    %{
      id: status.id,
      name: status.name
    }
  end

end
