IO.puts("Day 1: Historian Hysteria")

defmodule Helpers do
  def sortAtIndex(list, index) do
    list
    |> Enum.map(&String.to_integer(Enum.at(&1, index, "0")))
    |> Enum.sort()
  end
end

case File.read("input.txt") do
  {:ok, contents} ->
    nums =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "   "))

    lOne = Helpers.sortAtIndex(nums, 0)
    lTwo = Helpers.sortAtIndex(nums, 1)

    Enum.zip(lOne, lTwo)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
    |> IO.inspect(label: "Part 1")

    frequencies = Enum.frequencies(lTwo)

    lOne
    |> Enum.map(&(&1 * Map.get(frequencies, &1, 0)))
    |> Enum.sum()
    |> IO.inspect(label: "Part 2")

  {:error, :enoent} ->
    nil
end
