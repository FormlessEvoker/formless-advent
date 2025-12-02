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
      assert {:ok, ["I'm a little teapot"]} = Advent.run(Y2025.NthDay, "teapot.dat")
    end
  end
end
