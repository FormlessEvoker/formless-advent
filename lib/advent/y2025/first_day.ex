defmodule Advent.Y2025.FirstDay do
  @moduledoc """
  Solution for Advent of Code 2025 Day 1.
  """

  @doc """
  Solves the puzzle given a list of strings.

  ## Parameters

    - lines: A list of strings representing the puzzle input

  ## Returns

    - `:ok` for now (placeholder return value)

  ## Examples

      iex> Advent.Y2025.FirstDay.solve(["L50", "R14"])
      {:ok, 1}

  """
  def solve(lines) when is_list(lines) do
    with {:ok, turns} <- parse_data(lines) do
      {:ok, turns}
    end
  end

  defp parse_data(lines) when is_list(lines) do
    lines
    |> Enum.map(&parse_line/1)
    |> then(
      &case Keyword.get(&1, :error) do
        nil -> {:ok, &1}
        error -> {:error, error}
      end
    )
  end

  defp parse_line(<<"L", distance::binary>>) do
    {:left, String.to_integer(distance)}
  end

  defp parse_line(<<"R", distance::binary>>) do
    {:right, String.to_integer(distance)}
  end

  defp parse_line({:error, _} = err), do: err

  defp parse_line(junk) do
    {:error, "Bad input line: \"#{junk}\""}
  end
end
