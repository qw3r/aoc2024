# AoC

My solutions to Advent of Code 2024

## Tasks

### init_day
> it will create the module for the day, download the input and create a test_input where you can copy the example input for the day
>
> ```shell
> mix init_day 1
> ```


### day
> it run the day's solution
>
> ```shell
> mix day 03 1  # will run part1 of the 3rd day
> mix day 02 2  # will run part2 of the 2nd day
> mix day 02 2 -t # will run part2 of the 2nd day against the test/example data
> mix day 03 1 -b # will benchmark the part1 of the 3rd day
> ```


To make have to mix tasks work you have to create a file called `config.exs` in the `config` folder and add the following code:

```elixir
import Config

config :aoc,
       :cookie,
       "session=YOU_CAN_GET_IT_FROM_BROWSER_DEV_TOOLS"
```


note: The benchmarking and downloading part is not my creation, i copied from somewhere, but i don't remember where, if you know please let me know so i can give the proper credits.
