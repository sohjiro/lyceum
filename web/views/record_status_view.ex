defmodule Lyceum.RecordStatusView do
  use Lyceum.Web, :view

  def render("index.json", %{records_statuses: records_statuses}) do
    %{recordStatuses: render_many(records_statuses, Lyceum.RecordStatusView, "record_status.json")}
  end

  def render("show.json", %{record_status: record_status}) do
    %{recordStatus: render_one(record_status, Lyceum.RecordStatusView, "record_status.json")}
  end

  def render("record_status.json", %{record_status: record_status}) do
    %{
      id: record_status.id,
      status: record_status.status_id,
      record: record_status.record_id
    }
  end

end
