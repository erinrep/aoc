IO.puts "AoC 2020 - Day 9: Encoding Error"

defmodule Helpers do
  def is_sum?(prev_nums, num) do
    Enum.any?(prev_nums, fn n -> 
      Enum.find_value(prev_nums, fn m -> 
        n + m == num
      end)
    end)
  end
end

case File.read("numbers.txt") do
  {:ok, contents} ->
    numbers = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.to_integer(&1)))

    IO.puts "Part 1"
    preamble_length = 25
    {_preamble, numbers_to_test} = Enum.split(numbers, preamble_length)

    numbers_to_test
      |> Enum.with_index
      |> Enum.find_value(fn {num, index} -> 
        {prev_nums, _remainder} = Enum.split(numbers, index + preamble_length)

        is_sum? = prev_nums
          |> Enum.reverse
          |> Enum.take(preamble_length)
          |> Helpers.is_sum?(num)
        
        if !is_sum?, do: num
      end)
      |> IO.inspect

  {:error, :enoent} -> nil
end