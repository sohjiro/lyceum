defmodule Lyceum.EventView do
  use Lyceum.Web, :view

  def render("show.json", %{event: event}) do
    %{event: render_one(event, Lyceum.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      type: event.type,
      name: event.name,
      starting_date: event.starting_date,
      campus: event.campus,
      quorum: event.quorum,
      price: event.price
    }
  end

end
