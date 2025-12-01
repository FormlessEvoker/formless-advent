defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "greets the world" do
    assert Advent.run(Y2025.FirstDay) == :ok
  end
end
