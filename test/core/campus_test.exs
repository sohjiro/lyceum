defmodule Lyceum.Core.CampusTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Campus

  describe "List campuses" do
    test "should display all available campuses" do
      assert length(Campus.list) == 4
    end
  end

end
