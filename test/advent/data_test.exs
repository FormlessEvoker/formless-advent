defmodule Advent.DataTest do
  use ExUnit.Case
  doctest Advent.Data

  alias Advent.Data

  describe "module_to_path/1" do
    test "converts Advent.Y2025.FirstDay to correct path" do
      assert Data.module_to_path(Advent.Y2025.FirstDay) =~ "data/y_2025/first_day/sample.dat"
    end

    test "works without Advent prefix" do
      assert Data.module_to_path(Y2025.FirstDay) =~ "data/y_2025/first_day/sample.dat"
    end
  end

  describe "module_to_path/2" do
    test "converts Advent.Y2025.FirstDay with custom filename" do
      assert Data.module_to_path(Advent.Y2025.FirstDay, "input.dat") =~
               "data/y_2025/first_day/input.dat"
    end
  end

  describe "load/1" do
    test "loads data from sample file for Advent.Y2025.FirstDay" do
      {:ok, lines} = Data.load(Advent.Y2025.FirstDay)
      assert is_list(lines)

      for line <- lines do
        assert is_binary(line)
      end
    end

    test "returns error for non-existent module" do
      result = Data.load(Advent.Y2025.NonExistent)
      assert {:error, _reason} = result
    end
  end

  describe "load/2" do
    test "loads data from the specified file" do
      {:ok, dummy_contents} = Data.load(Advent.Y2025.Test, filename: "dummy_file.dat")
      assert ["I'm a little teapot"] == dummy_contents
    end

    test "returns an error when attempting to pass a filepath instead of just a file name" do
      assert {:error, "Passing a path to a data file is prohibited. Must pass only the filename."} =
               Data.load(Advent.Y2025.FirstDay, filename: "../../../../etc/passwd")
    end

    test "returns error when loading non-existent file with custom filename" do
      result = Data.load(Advent.Y2025.FirstDay, filename: "fake_file.datum")
      assert {:error, :enoent} = result
    end
  end

  describe "load!/1" do
    test "loads data from sample file successfully" do
      lines = Data.load!(Advent.Y2025.FirstDay)
      assert is_list(lines)

      for line <- lines do
        assert is_binary(line)
      end
    end

    test "raises File.Error for non-existent module" do
      assert_raise File.Error, fn ->
        Data.load!(Advent.Y2025.NonExistent)
      end
    end
  end

  describe "load!/2" do
    test "loads data from the specified file successfully" do
      dummy_contents = Data.load!(Advent.Y2025.Test, filename: "dummy_file.dat")
      assert ["I'm a little teapot"] == dummy_contents
    end

    test "raises ArgumentError when attempting to pass a filepath" do
      assert_raise ArgumentError, ~r/Passing a path to a data file is prohibited/, fn ->
        Data.load!(Advent.Y2025.FirstDay, filename: "../../../../etc/passwd")
      end
    end

    test "raises File.Error when file does not exist" do
      assert_raise File.Error, fn ->
        Data.load!(Advent.Y2025.FirstDay, filename: "fake_file.datum")
      end
    end
  end
end
