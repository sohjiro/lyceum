defmodule Lyceum.Core.RecordStatusTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.RecordStatus

  describe "Record status flow" do
    test "Add status for a record" do
      candidate = %Lyceum.Candidate{name: "Name lastname"} |> Repo.insert!
      record = %Lyceum.Record{candidate_id: candidate.id} |> Repo.insert!
      params = %{"status" => 2, "record" => record.id}

      {:ok, record_status} = RecordStatus.create(params)

      assert record_status.id
      assert record_status.status_id == 2
      assert record_status.record_id == record.id
      assert Repo.preload(record, :statuses).statuses |> length == 1
    end

    test "Don't allow to duplicate previous register" do
      candidate = %Lyceum.Candidate{name: "Name lastname"} |> Repo.insert!
      record = %Lyceum.Record{candidate_id: candidate.id} |> Repo.insert!
      %Lyceum.RecordStatus{status_id: 1, record_id: record.id} |> Repo.insert!

      params = %{"status" => 1, "record" => record.id}

      {:ok, record_status} = RecordStatus.create(params)

      assert record_status.id
      assert record_status.status_id == 1
      assert record_status.record_id == record.id
      assert Repo.preload(record, :statuses).statuses |> length == 1
    end
  end

end
