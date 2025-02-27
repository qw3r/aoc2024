defmodule AoC.Day01 do
  def part1(input) do
    {left, right} = input |> parse_input()

    Enum.with_index(left)
    |> Enum.map(fn {l, i} -> abs(l - Enum.at(right, i)) end)
    |> Enum.sum()
  end

  def part2(input) do
    {left, right} = parse_input(input)

    left
    |> Enum.map(fn l -> l * Enum.count(right, &(&1 == l)) end)
    |> Enum.sum()
  end

  def find_integers(line) do
    ints = Enum.filter(line, fn char -> char in ?0..?9 end)
    first = hd(ints)
    last = hd(Enum.reverse(ints))
    [first, last] |> List.to_integer()
  end

  # Ugly hack to consider stuff like "oneight" as "18"
  def replace_spelt_numbers("one" <> rest), do: "1" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("two" <> rest), do: "2" <> replace_spelt_numbers("o" <> rest)
  def replace_spelt_numbers("three" <> rest), do: "3" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("four" <> rest), do: "4" <> replace_spelt_numbers("r" <> rest)
  def replace_spelt_numbers("five" <> rest), do: "5" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("six" <> rest), do: "6" <> replace_spelt_numbers("x" <> rest)
  def replace_spelt_numbers("seven" <> rest), do: "7" <> replace_spelt_numbers("n" <> rest)
  def replace_spelt_numbers("eight" <> rest), do: "8" <> replace_spelt_numbers("t" <> rest)
  def replace_spelt_numbers("nine" <> rest), do: "9" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers(<<char, rest::binary>>), do: <<char>> <> replace_spelt_numbers(rest)
  def replace_spelt_numbers(""), do: ""

  def parse_input(input) do
    pairs =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn pairs ->
        String.split(pairs, ~r{\s+}, trim: true) |> Enum.map(&String.to_integer/1)
      end)

    {
      Enum.map(pairs, fn [l, _r] -> l end) |> Enum.sort(),
      Enum.map(pairs, fn [_l, r] -> r end) |> Enum.sort()
    }
  end
end
