defmodule Lyceum.Core.StatusTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Status

  describe "List statuses" do
    test "should display all available status" do
      assert length(Status.list) == 5
    end
  end

end
