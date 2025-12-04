defmodule Advent.Y2025.FirstDay do
  @moduledoc """
  Solution for Advent of Code 2025 Day 1.
  """

  @default_starting_value 50

  @type answer :: {landed_on_zero_count :: pos_integer(), passed_zero_count :: pos_integer()}

  @doc """
  Solves the puzzle given a list of strings.
  """
  @spec solve([String.t()]) :: {:ok, answer()} | {:error, any()}
  def solve(lines) when is_list(lines) do
    with {:ok, turns} <- parse_data(lines) do
      %{landed_on: landed_on, passed: passed} =
        turns
        |> Enum.reduce(%{value: @default_starting_value, landed_on: 0, passed: 0}, &move_dial/2)

      {:ok, {landed_on, passed}}
    end
  end

  defp move_dial(distance, %{value: value, landed_on: landed_on, passed: passed}) do
    # "move" is a representation of the total value of the result of the
    # turn of the dial if it was a continuous number line, rather than a cycle from 0-99
    move = value + distance

    # The new value is what the arrow points to after the dial is turned the given distance
    # Since it's a rotary dial with 100 possible numbers, we divide by 100 and use the remainder
    # AKA "mod" operator
    new_value = Integer.mod(move, 100)

    # This is the number of times we've spun the dial in a complete circle
    full_rotations = div(abs(distance), 100)

    # Ignoring all the full rotations, this is ultimately the actual distance that the
    # dial moves from its original value
    partial_rotation_distance =
      cond do
        distance > 0 -> Integer.mod(distance, 100)
        distance == 0 -> 0
        distance < 0 -> -Integer.mod(abs(distance), 100)
      end

    # This is the movement result from just the non-full rotation clicks
    partial_move = value + partial_rotation_distance

    # For all the clicks we moved after all the full rotations, did we end up passing 0?
    passed_zero_during_partial_rotation =
      cond do
        # If we started this turn on 0, it doesn't count
        value == 0 -> 0
        # If as a result of moving, we've gone above 99 or below 1, that's passing 0
        partial_move > 99 or partial_move < 1 -> 1
        # 🤷
        true -> 0
      end

    # Full rotations, but we also want to add 1 if the partial rotation passed 0
    times_passed_zero = full_rotations + passed_zero_during_partial_rotation

    # Did we land on 0?
    landed_on =
      if new_value == 0 do
        landed_on + 1
      else
        landed_on
      end

    %{
      value: new_value,
      landed_on: landed_on,
      passed: passed + times_passed_zero
    }
  end

  defp parse_data(lines) when is_list(lines) do
    Enum.reduce_while(lines, [], fn line, acc ->
      case parse_line(line) do
        {:error, msg} -> {:halt, {:error, msg}}
        parsed -> {:cont, [parsed | acc]}
      end
    end)
    |> case do
      {:error, msg} -> {:error, msg}
      results -> {:ok, Enum.reverse(results)}
    end
  end

  defp parse_line(<<"L", distance::binary>>) do
    case Integer.parse(distance) do
      {int, ""} -> -int
      _ -> {:error, "Invalid distance for left turn: \"#{distance}\""}
    end
  end

  defp parse_line(<<"R", distance::binary>>) do
    case Integer.parse(distance) do
      {int, ""} -> int
      _ -> {:error, "Invalid distance for right turn: \"#{distance}\""}
    end
  end

  defp parse_line({:error, _} = err), do: err

  defp parse_line(junk) do
    {:error, "Bad input line: \"#{junk}\""}
  end
end
