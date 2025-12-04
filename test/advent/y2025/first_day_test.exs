defmodule Advent.Y2025.FirstDayTest do
  use ExUnit.Case, async: true
  doctest Advent.Y2025.FirstDay

  alias Advent.Y2025.FirstDay

  describe "solve/1" do
    test "returns value for empty list" do
      assert FirstDay.solve([]) == {:ok, {0, 0}}
    end

    test "returns solution" do
      assert {:ok, {1, 1}} = FirstDay.solve(["L50", "R99"])
    end

    test "returns an error when input is bad" do
      assert {:error, _} = FirstDay.solve(["L7", "weanies"])
    end
  end
end
