defmodule Advent do
  @moduledoc """
  Documentation for `Advent`.
  """

  @doc """
  Loads puzzle data and executes the solution for the given Advent of Code module.

  The module should implement a `solve/1` function that accepts the loaded data.

  ## Examples

      iex> {:ok, _} = Advent.run(Advent.Y2025.FirstDay)

  """
  def run(module_name) do
    full_module = advent_module(module_name)

    full_module
    |> Advent.Data.load!()
    |> then(&apply(full_module, :solve, [&1]))
  end

  @doc """
  Loads puzzle data from a custom file and executes the solution for the given Advent of Code module.

  The module should implement a `solve/1` function that accepts the loaded data.

  ## Parameters

    - module_name: The module atom (e.g., `Advent.Y2025.FirstDay`)
    - input_filename: The name of the data file to load (must be a valid filename without path separators)

  ## Examples

      iex> {:ok, _} = Advent.run(Advent.Y2025.FirstDay, "test_input.dat")

  """
  def run(module_name, input_filename) do
    full_module = advent_module(module_name)

    full_module
    |> Advent.Data.load!(filename: input_filename)
    |> then(&apply(full_module, :solve, [&1]))
  end

  defp advent_module(module_name) when is_atom(module_name) do
    Module.split(module_name)
    |> advent_module()
    |> Module.concat()
  end

  defp advent_module(["Advent" | _] = parts), do: parts

  defp advent_module(parts) when is_list(parts), do: ["Advent" | parts]
end
