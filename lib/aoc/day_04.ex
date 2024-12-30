defmodule AoC.Day04 do
  def part1(input) do
    letters = "XMAS" |> String.split("", trim: true)
    {grid, max_rows, max_columns} = build_grid(input)

    for row <- 0..(max_rows - 1), column <- 0..(max_columns - 1) do
      [
        check_(&move_right/2, grid, row, column, letters),
        check_(&move_left/2, grid, row, column, letters),
        check_(&move_down/2, grid, row, column, letters),
        check_(&move_up/2, grid, row, column, letters),
        check_(&move_up_right/2, grid, row, column, letters),
        check_(&move_down_right/2, grid, row, column, letters),
        check_(&move_down_left/2, grid, row, column, letters),
        check_(&move_up_left/2, grid, row, column, letters)
      ]
    end
    |> List.flatten()
    |> Enum.count(&(&1 == :o))
  end

  def part2(input) do
    {grid, max_rows, max_columns} = build_grid(input)

    for row <- 0..(max_rows - 1), column <- 0..(max_columns - 1) do
      case grid[row][column] do
        "A" -> check_for_cross_masses(grid, row, column)
        _ -> false
      end
    end
    |> Enum.count(& &1)
  end

  defp move_right(row, column), do: {row, column + 1}
  defp move_down(row, column), do: {row + 1, column}
  defp move_left(row, column), do: {row, column - 1}
  defp move_up(row, column), do: {row - 1, column}
  defp move_up_right(row, column), do: {row - 1, column + 1}
  defp move_down_right(row, column), do: {row + 1, column + 1}
  defp move_down_left(row, column), do: {row + 1, column - 1}
  defp move_up_left(row, column), do: {row - 1, column - 1}

  defp check_for_cross_masses(grid, row, column) do
    # IO.inspect(%{
    #   row: row,
    #   column: column,
    #   middle: grid[row][column],
    #   tl: grid[row - 1][column - 1],
    #   tr: grid[row - 1][column + 1],
    #   bl: grid[row + 1][column - 1],
    #   br: grid[row + 1][column + 1]
    # })

    top_left = grid[row - 1][column - 1] || ""
    bottom_right = grid[row + 1][column + 1] || ""
    top_right = grid[row - 1][column + 1] || ""
    bottom_left = grid[row + 1][column - 1] || ""

    tlbr = top_left <> bottom_right
    trbl = top_right <> bottom_left

    pattern = ~r"MS|SM"
    tlbr =~ pattern && trbl =~ pattern
  end

  defp check_(_, _, _, _, []), do: :o

  defp check_(move_fn, grid, row, column, [l | letters]) do
    # IO.inspect(%{row: row, column: column, v: grid[row][column], l: l, letters: letters})

    {next_row, next_column} = move_fn.(row, column)

    case grid[row][column] do
      ^l -> check_(move_fn, grid, next_row, next_column, letters)
      _ -> :x
    end
  end

  defp build_grid(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))
      |> from_list()

    {grid, map_size(grid), map_size(grid[0])}
  end

  defp from_list(list) when is_list(list) do
    do_from_list(list)
  end

  defp do_from_list(list, map \\ %{}, index \\ 0)
  defp do_from_list([], map, _index), do: map

  defp do_from_list([h | t], map, index) do
    map = Map.put(map, index, do_from_list(h))
    do_from_list(t, map, index + 1)
  end

  defp do_from_list(other, _, _), do: other
end
