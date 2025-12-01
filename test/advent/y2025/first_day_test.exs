defmodule Advent.Y2025.FirstDayTest do
  use ExUnit.Case
  doctest Advent.Y2025.FirstDay

  alias Advent.Y2025.FirstDay

  describe "solve/1" do
    test "returns :ok for empty list" do
      assert FirstDay.solve([]) == :ok
    end

    test "returns :ok for list with strings" do
      assert FirstDay.solve(["line1", "line2"]) == :ok
    end
  end
end
