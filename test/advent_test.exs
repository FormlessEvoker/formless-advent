defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "run/1" do
    test "loads and solves a puzzle with default filename" do
      assert {:ok, _} = Advent.run(Y2025.FirstDay)
    end
  end

  describe "run/2" do
    test "loads and solves a puzzle with custom filename" do
      result = Advent.run(Y2025.FirstDay, "test_input.dat")
      assert {:ok, turns} = result
      assert turns == [{:left, 10}, {:right, 20}, {:left, 30}]
    end
  end
end
