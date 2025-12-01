defmodule Advent do
  @moduledoc """
  Documentation for `Advent`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Advent.run(Advent.Y2025.FirstDay)
      :ok

  """
  def run(module_name) do
    full_module = advent_module(module_name)

    full_module
    |> Advent.Data.load!()
    |> then(&apply(full_module, :solve, [&1]))
  end

  def run(module_name, input_filename) do
    full_module = advent_module(module_name)

    full_module
    |> Advent.Data.load!(filename: input_filename)
    |> then(&apply(full_module, :solve, [&1]))
  end

  defp advent_module(module_name) when is_atom(module_name) do
    Module.split(module_name)
    |> advent_module()
  end

  defp advent_module(["Advent" | _] = parts) do
    Module.concat(parts)
  end

  defp advent_module(parts) when is_list(parts) do
    Module.concat(["Advent" | parts])
  end
end
