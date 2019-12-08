defmodule IntcodeComputer do
  def noun_spot, do: 1
  def verb_spot, do: 2

  def process_instruction(index, intcode) do
    intcode
      |> Enum.drop(index)
      |> process_instruction(index, intcode)
  end
  def process_instruction([99 | _tail], _index, intcode), do: intcode
  def process_instruction([1, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) + Enum.at(intcode, b))
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([101, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, a + Enum.at(intcode, b))
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([1001, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) + b)
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([1101, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, a + b)
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([2, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) * Enum.at(intcode, b))
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([102, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, a * Enum.at(intcode, b))
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([1002, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) * b)
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([1102, a, b, c | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, c, a * b)
    process_instruction(index + 4, new_intcode)
  end
  def process_instruction([3, a | _tail], index, intcode) do
    new_intcode = List.replace_at(intcode, a, 1)
    process_instruction(index + 2, new_intcode)
  end
  def process_instruction([4, a | _tail], index, intcode) do
    intcode
      |> Enum.at(a)
      |> IO.inspect
    process_instruction(index + 2, intcode)
  end
  def process_instruction([104, a | _tail], index, intcode) do
    process_instruction(index + 2, intcode)
  end

  def process_intcode(intcode) do
    intcode
      |> process_instruction(0, intcode)
      |> List.first
  end
end

IO.puts "AoC 2019 - 5"

case File.read("intcode.txt") do
  {:ok, contents} ->
    intcode = contents
    |> String.split(",", trim: true)
    |> Enum.map(&(String.to_integer(&1)))

    IntcodeComputer.process_intcode(intcode)
    
  {:error, :enoent} -> nil
end