defmodule Advent.Data do
  @moduledoc """
  Module for loading puzzle input data.

  This module converts Advent of Code module names to file paths and loads
  the corresponding data files. Module names must follow the convention:
  `Advent.Y<YEAR>.<DayName>` (e.g., `Advent.Y2025.FirstDay`).
  """

  @default_filename "input.dat"

  @doc """
  Loads puzzle data for a given module.

  Converts the module name to a file path and reads the corresponding
  binary file, returning its contents as a list of strings (one per line).

  ## Parameters

    - module_name: The module atom (e.g., `Advent.Y2025.FirstDay`)
    - opts: Keyword list of options
      - `:filename` - The data file name to load (default: "#{@default_filename}")

  ## Returns

    - `{:ok, lines}` where `lines` is a list of strings
    - `{:error, reason}` if the file cannot be read

  ## Examples

      iex> {:ok, _} = Advent.Data.load(Advent.Y2025.FirstDay)

      iex> Advent.Data.load(Advent.Y2025.FirstDay, filename: "garbage.dat")
      {:error, :enoent}

  """
  def load(module_name, opts \\ []) when is_atom(module_name) do
    filename = Keyword.get(opts, :filename, @default_filename)

    with {:ok, filename} <- validate_filename(filename),
         file_path <- module_to_path(module_name, filename),
         {:ok, content} <- File.read(file_path) do
      lines =
        content
        |> String.split("\n")
        |> Enum.reject(&(String.trim(&1) == ""))

      {:ok, lines}
    end
  end

  @doc """
  Loads puzzle data for a given module, raising an exception on error.

  This is the bang variant of `load/2`. It behaves the same way but raises
  an exception instead of returning an error tuple when file loading fails.

  ## Parameters

    - module_name: The module atom (e.g., `Advent.Y2025.FirstDay`)
    - opts: Keyword list of options
      - `:filename` - The data file name to load (default: "#{@default_filename}")

  ## Returns

    - A list of strings (one per line) on success

  ## Raises

    - `ArgumentError` if the filename is invalid (contains path separators or invalid characters)
    - `File.Error` if the file cannot be read (e.g., file not found, permission denied)

  ## Examples

      iex> lines = Advent.Data.load!(Advent.Y2025.FirstDay)
      iex> is_list(lines)
      true

      iex> Advent.Data.load!(Advent.Y2025.FirstDay, filename: "../../etc/passwd")
      ** (ArgumentError) Passing a path to a data file is prohibited. Must pass only the filename.

  """
  def load!(module_name, opts \\ []) do
    case load(module_name, opts) do
      {:ok, content} ->
        content

      {:error, msg} when is_binary(msg) ->
        raise ArgumentError, msg

      {:error, reason} ->
        filename = Keyword.get(opts, :filename, @default_filename)
        file_path = module_to_path(module_name, filename)
        raise File.Error, reason: reason, action: "read file", path: file_path
    end
  end

  @doc """
  Converts a module name to a file path.

  Expects module names in the format `Advent.Y<YEAR>.<DayName>` where:
  - `Y<YEAR>` is converted to `y_<year>` (e.g., `Y2025` -> `y_2025`)
  - `<DayName>` is converted to snake_case (e.g., `FirstDay` -> `first_day`)

  ## Parameters

    - module_name: The module atom (e.g., `Advent.Y2025.FirstDay`)
    - filename: The data file name (default: "input.dat")

  ## Returns

    - A string representing the file path

  ## Examples

      iex> Advent.Data.module_to_path(Advent.Y2025.FirstDay)
      "data/y_2025/first_day/input.dat"

      iex> Advent.Data.module_to_path(Advent.Y2025.FirstDay, "sample.dat")
      "data/y_2025/first_day/sample.dat"

  """
  def module_to_path(module_name, filename \\ @default_filename) do
    module_name
    |> Module.split()
    # Drop "Advent" prefix
    |> case do
      ["Advent" | rest] -> rest
      path -> path
    end
    |> Enum.map(&convert_part/1)
    |> then(fn parts -> [filename | Enum.reverse(["data" | parts])] |> Enum.reverse() end)
    |> Path.join()
  end

  defp validate_filename(filename) when is_binary(filename) do
    # Only allow alphanumeric characters, underscores, hyphens, and dots
    # This prevents path traversal while allowing reasonable filenames
    if String.match?(filename, ~r/^[a-zA-Z0-9_\-.]+$/) and not String.contains?(filename, "..") do
      {:ok, filename}
    else
      {:error, "Passing a path to a data file is prohibited. Must pass only the filename."}
    end
  end

  # Convert module name parts to file path segments
  # Y2025 -> y_2025 (handles year format starting with 'Y')
  # FirstDay -> first_day
  defp convert_part("Y" <> year) do
    "y_" <> String.downcase(year)
  end

  defp convert_part(part) do
    part
    |> Macro.underscore()
  end
end
