IO.puts "AoC 2020 - Day 8: Handheld Halting"

defmodule Helpers do
  def evaluate(instructions, index, acc, checklist) do
    [operation, num] = instructions
      |> Enum.at(index)
      |> String.split(" ")
    
    {next_index, amount} = case operation do
      "nop" -> {index + 1, 0}
      "acc" -> {index + 1, String.to_integer(num)}
      "jmp" -> {index + String.to_integer(num), 0}
    end

    case MapSet.member?(checklist, next_index) do
      true -> acc
      false -> evaluate(instructions, next_index, acc + amount, MapSet.put(checklist, next_index)) 
    end
  end
end

case File.read("instructions.txt") do
  {:ok, contents} ->
    instructions = contents
      |> String.split("\n", trim: true)

    IO.puts "Part 1"
    instructions
      |> Helpers.evaluate(0, 0, MapSet.new())
      |> IO.inspect

  {:error, :enoent} -> nil
end