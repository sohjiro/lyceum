defmodule Lyceum.RecordView do
  use Lyceum.Web, :view

  def render("index.json", %{records: records}) do
    %{records: render_many(records, Lyceum.RecordView, "record.json")}
  end

  def render("show.json", %{record: record}) do
    %{record: render_one(record, Lyceum.RecordView, "record.json")}
  end

  def render("record.json", %{record: record}) do
    %{
      id: record.id,
      candidate_id: record.candidate_id,
      event_id: record.event_id
    }
  end

end
