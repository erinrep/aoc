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
  
  def evaluate_part_2(instructions, index, acc, checklist) do
    [operation, num] = instructions
      |> Enum.at(index)
      |> String.split(" ")
    
    {next_index, amount} = case operation do
      "nop" -> {index + 1, 0}
      "acc" -> {index + 1, String.to_integer(num)}
      "jmp" -> {index + String.to_integer(num), 0}
    end
    
    used_index? = MapSet.member?(checklist, next_index)
    cond do
      next_index == Enum.count(instructions) -> {next_index, acc + amount}
      used_index? == true -> {next_index, acc}
      used_index? == false -> evaluate_part_2(instructions, next_index, acc + amount, MapSet.put(checklist, next_index)) 
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
    
    IO.puts "Part 2"
    num_instructions = Enum.count(instructions)
    0..num_instructions - 1
      |> Enum.map(fn i ->
        instructions
          |> Enum.with_index
          |> Enum.map(fn {instruction, index} -> 
            case index == i do
              true -> case String.split(instruction, " ") do
                ["nop", "+0"] -> nil
                ["nop", num] -> "jmp #{num}"
                ["acc", _] -> nil
                ["jmp", num] -> "nop #{num}"
              end
              false -> instruction
            end
          end)
      end)
      |> Enum.filter(fn x -> 
        !Enum.any?(x, &(&1 == nil))
      end)
      |> Enum.find_value(fn modified_instructions ->
        {index, num} = Helpers.evaluate_part_2(modified_instructions, 0, 0, MapSet.new())
         if index == num_instructions, do: num
      end)
      |> IO.inspect()

  {:error, :enoent} -> nil
end