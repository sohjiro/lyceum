defmodule Lyceum.RecordStatusView do
  use Lyceum.Web, :view

  def render("show.json", %{record_status: record_status}) do
    %{type: render_one(record_status, Lyceum.RecordStatusView, "record_status.json")}
  end

  def render("record_status.json", %{record_status: record_status}) do
    %{
      status: record_status.status_id,
      record: record_status.record_id
    }
  end

end
