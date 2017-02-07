defmodule Lyceum.EventView do
  use Lyceum.Web, :view

  def render("index.json", %{events: events}) do
    %{events: render_many(events, Lyceum.EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{event: render_one(event, Lyceum.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      starting_date: event.starting_date,
      quorum: event.quorum,
      price: event.price,
      type: event.type_id,
      campus: event.campus_id,
      subject: event.subject_id,
      links: %{
        "records": "#{event.id}/records"
      }
    }
  end

end
