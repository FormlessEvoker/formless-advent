defmodule Advent.Data do
  @moduledoc """
  Module for loading puzzle input data.
  """

  @doc """
  Loads puzzle data for a given module.

  Converts the module name to a file path and reads the corresponding
  binary file, returning its contents as a list of strings (one per line).

  ## Parameters

    - module_name: The module atom (e.g., `Advent.Y2025.FirstDay`)

  ## Returns

    - `{:ok, lines}` where `lines` is a list of strings
    - `{:error, reason}` if the file cannot be read

  ## Examples

      iex> Advent.Data.load(Advent.Y2025.FirstDay)
      {:ok, ["sample line 1", "sample line 2", "sample line 3"]}

  """
  def load(module_name) when is_atom(module_name) do
    file_path = module_to_path(module_name)

    case File.read(file_path) do
      {:ok, content} ->
        lines =
          content
          |> String.split("\n")
          |> Enum.reject(&(&1 == ""))

        {:ok, lines}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Converts a module name to a file path.

  ## Parameters

    - module_name: The module atom (e.g., `Advent.Y2025.FirstDay`)

  ## Returns

    - A string representing the file path

  ## Examples

      iex> Advent.Data.module_to_path(Advent.Y2025.FirstDay)
      "data/y_2025/first_day/sample.dat"

  """
  def module_to_path(module_name) do
    module_name
    |> Module.split()
    # Drop "Advent" prefix
    |> Enum.drop(1)
    |> Enum.map(&convert_part/1)
    |> then(fn parts -> ["data" | parts] ++ ["sample.dat"] end)
    |> Path.join()
  end

  # Convert module name parts to file path segments
  # Y2025 -> y_2025
  # FirstDay -> first_day
  defp convert_part("Y" <> year) do
    "y_" <> String.downcase(year)
  end

  defp convert_part(part) do
    part
    |> Macro.underscore()
  end
end
