defmodule Advent.DataTest do
  use ExUnit.Case
  doctest Advent.Data

  alias Advent.Data

  describe "module_to_path/1" do
    test "converts Advent.Y2025.FirstDay to correct path" do
      assert Data.module_to_path(Advent.Y2025.FirstDay) == "data/y_2025/first_day/sample.dat"
    end
  end

  describe "module_to_path/2" do
    test "converts Advent.Y2025.FirstDay with custom filename" do
      assert Data.module_to_path(Advent.Y2025.FirstDay, "input.dat") ==
               "data/y_2025/first_day/input.dat"
    end
  end

  describe "load/1" do
    test "loads data from sample file for Advent.Y2025.FirstDay" do
      {:ok, lines} = Data.load(Advent.Y2025.FirstDay)
      assert is_list(lines)
      assert length(lines) == 3
      assert Enum.at(lines, 0) == "sample line 1"
      assert Enum.at(lines, 1) == "sample line 2"
      assert Enum.at(lines, 2) == "sample line 3"
    end

    test "returns error for non-existent module" do
      result = Data.load(Advent.Y2025.NonExistent)
      assert {:error, _reason} = result
    end
  end

  describe "load/2" do
    test "returns error when loading non-existent file with custom filename" do
      result = Data.load(Advent.Y2025.FirstDay, filename: "input.dat")
      assert {:error, :enoent} = result
    end
  end
end
