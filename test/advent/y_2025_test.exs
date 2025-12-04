defmodule Advent.Y2025Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias Advent.Y2025

  describe "First Day Part 1" do
    test "solved with sample dataset" do
      assert {:ok, {3, _}} = Advent.run(Y2025.FirstDay, "sample.dat")
    end

    test "solved with official dataset" do
      assert {:ok, {1102, _}} = Advent.run(Y2025.FirstDay)
    end
  end

  describe "First Day Part 2" do
    test "solved with sample dataset" do
      assert {:ok, {_, 6}} = Advent.run(Y2025.FirstDay, "sample.dat")
    end

    test "solved with official dataset" do
      assert {:ok, {_, 6175}} = Advent.run(Y2025.FirstDay)
    end
  end
end
