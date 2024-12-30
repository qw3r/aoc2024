defmodule AoC.Day03 do
  def part1(input) do
    input
    |> collect_instructions()
    |> parse_instructions()
    |> Enum.map(&execute_instruction/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> collect_instructions()
    |> parse_instructions()
    |> Enum.reduce({true, 0}, fn instruction, {enabled, result} ->
      # IO.inspect(%{instruction: instruction, enabled: enabled, result: result})

      case instruction do
        {:disabled} ->
          {false, result}

        {:enabled} ->
          {true, result}

        {:mul, a, b} ->
          if enabled do
            {true, result + a * b}
          else
            {enabled, result}
          end
      end
    end)
    |> elem(1)
  end

  defp collect_instructions(input) do
    Regex.scan(~r"mul\(\d{1,3}\,\d{1,3}\)|don't\(\)|do\(\)", input)
    |> List.flatten()
  end

  defp parse_instructions(input) do
    Enum.map(input, fn instruction ->
      case Regex.scan(~r"(mul)\((\d{1,3}),(\d{1,3})\)|(do|don't)\(\)", instruction) do
        [[_, "mul", a, b]] ->
          {:mul, String.to_integer(a), String.to_integer(b)}

        [[_, "", "", "", "don't"]] ->
          {:disabled}

        [[_, "", "", "", "do"]] ->
          {:enabled}

        _ ->
          {:invalid, instruction}
      end
    end)
  end

  defp execute_instruction({:mul, a, b}) do
    a * b
  end

  defp execute_instruction(_) do
    0
  end
end
