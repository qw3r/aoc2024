defmodule AoC.Day05 do
  @very_small -9_999_999_999_999_999
  @very_big 9_999_999_999_999_999

  def part1(input) do
    {rules, updates} = parse_input(input)

    Enum.reduce(updates, 0, fn update, acc ->
      case valid_update?(update, rules) do
        true ->
          # IO.inspect(update)
          acc + get_middle(update)

        false ->
          acc
      end
    end)
  end

  def part2(input) do
    {rules, updates} = parse_input(input)

    Enum.filter(updates, fn update -> !valid_update?(update, rules) end)
    |> Enum.reduce(0, fn update, acc ->
      correct_update(update, rules) |> get_middle() |> Kernel.+(acc)
    end)
  end

  defp correct_update(update, rules) do
    rules
    |> Enum.reduce(update, fn {lead, follow}, acc ->
      # IO.inspect(%{
      # rule: {lead, follow},
      # update: acc,
      # li: Map.get(acc, lead),
      # fi: Map.get(acc, follow)
      # })

      # acc
      # |> IO.inspect()

      li = acc[lead]
      fi = acc[follow]

      if is_nil(li) || is_nil(fi) do
        acc
      else
        if li > fi do
          correct_update(%{acc | lead => fi, follow => li}, rules)
        else
          acc
        end
      end
    end)
  end

  defp valid_update?(update, rules) do
    rules
    |> Enum.reduce(true, fn {lead, follow}, acc ->
      # IO.inspect(%{
      #   rule: {lead, follow},
      #   update: update,
      #   li: Map.get(update, lead, -2),
      #   fi: Map.get(update, follow, -1)
      # })

      if Map.get(update, lead, @very_small) <
           Map.get(update, follow, @very_big) do
        acc
      else
        false
      end
    end)
  end

  defp parse_input(input) do
    [rules, updates] = input |> String.split("\n\n", trim: true)

    {
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "|", trim: true) |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end),
      updates
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {value, index}, acc ->
          Map.put(acc, value, index)
        end)
      end)
    }
  end

  defp get_middle(update) do
    middle_index = (map_size(update) / 2) |> floor()
    Map.to_list(update) |> Enum.find(fn {_, i} -> i == middle_index end) |> elem(0)
  end
end
