defmodule Advent.Y2025.FirstDayTest do
  use ExUnit.Case
  doctest Advent.Y2025.FirstDay

  alias Advent.Y2025.FirstDay

  describe "solve/1" do
    test "returns :ok for empty list" do
      assert FirstDay.solve([]) == :ok
    end

    test "returns :ok for list with strings" do
      # assert FirstDay.solve(["L50", "R99"]) == :ok

      assert FirstDay.solve(["L7", "weanies"]) == :ok
    end

    # test "raises when input is bad" do
    #   assert_raise
    # end
  end
end
