defmodule Advent.Y2025.FirstDayTest do
  use ExUnit.Case
  doctest Advent.Y2025.FirstDay

  alias Advent.Y2025.FirstDay

  describe "solve/1" do
    test "returns value for empty list" do
      assert FirstDay.solve([]) == {:ok, []}
    end

    test "returns for list with strings" do
      assert {:ok, _} = FirstDay.solve(["L50", "R99"])
    end

    test "returns an error when input is bad" do
      assert {:error, _} = FirstDay.solve(["L7", "weanies"])
    end
  end
end
