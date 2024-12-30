defmodule AoC.Day02 do
  def part1(input) do
    input
    |> parse_input()
    |> Enum.filter(&safety_check/1)
    |> length
    |> IO.inspect(label: "number of safe reports")
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.filter(fn levels ->
      safe? = safety_check(levels)

      if not safe? do
        !!(0..length(levels)
           |> Enum.find(fn level_idx_to_remove ->
             levels
             |> List.delete_at(level_idx_to_remove)
             |> safety_check(true)
           end))
      else
        safe?
      end
    end)
    |> length
    |> IO.inspect(label: "number of safe reports")
  end

  defp p1_count_unsafe_steps(levels) do
    Enum.chunk_every(levels, 2, 1, :discard)
    |> Enum.count(fn [a, b] ->
      diff = abs(a - b)
      diff < 1 || diff > 3
    end)
  end

  defp safety_check(levels, dampened \\ false) do
    prefix =
      case dampened do
        true -> "   ==>"
        false -> ""
      end

    if Enum.sort(levels, :asc) != levels && Enum.sort(levels, :desc) != levels do
      IO.inspect(levels,
        label: "#{prefix} unsafe: neither decreasing or increasing",
        charlists: :as_lists
      )

      false
    else
      if p1_count_unsafe_steps(levels) > 0 do
        IO.inspect(levels,
          label: "#{prefix} unsafe: step are too low or too high",
          charlists: :as_lists
        )

        false
      else
        IO.inspect(levels, label: "#{prefix} safe", charlists: :as_lists)
        true
      end
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> line |> String.split(" ") |> Enum.map(&String.to_integer/1) end)
  end
end
