defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "greets the world" do
    assert {:ok, _} = Advent.run(Y2025.FirstDay)
  end
end
