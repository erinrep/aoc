defmodule IntcodeComputer do
  def noun_spot, do: 1
  def verb_spot, do: 2

  def process_instruction([99 | _tail], intcode), do: intcode
  def process_instruction([1, a, b, c | tail], intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) + Enum.at(intcode, b))
    process_instruction(tail, new_intcode)
  end
  def process_instruction([2, a, b, c | tail], intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) * Enum.at(intcode, b))
    process_instruction(tail, new_intcode)
  end

  def process_intcode(intcode) do
    intcode
      |> IntcodeComputer.process_instruction(intcode)
      |> List.first
  end
end

IO.puts "AoC 2019 - 2"

desired_result = 
  System.argv()
    |> List.first()
    |> String.to_integer

case File.read("intcode.txt") do
  {:ok, contents} ->
    intcode = contents
      |> String.split(",", trim: true)
      |> Enum.map(&(String.to_integer(&1)))
 
    case 0..99
      |> Stream.flat_map(fn noun -> 
        0..99
          |> Stream.map(fn verb -> 
            result = intcode
              |> List.replace_at(IntcodeComputer.noun_spot, noun)
              |> List.replace_at(IntcodeComputer.verb_spot, verb)
              |> IntcodeComputer.process_intcode()
            {noun, verb, result}
          end)
      end)
      |> Enum.find(fn {_noun, _verb, result} ->
        result == desired_result
      end) do
    {noun, verb, _result} -> IO.inspect(100 * noun + verb)
    nil -> IO.inspect("result not found")
  end
    
  {:error, :enoent} -> nil
end