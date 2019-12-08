defmodule IntcodeComputer do
  def noun_spot, do: 1
  def verb_spot, do: 2
  def system_id, do: 1 # air onditioner unit

  def process_instruction(intcode, index) do
    intcode
      |> Enum.drop(index)
      |> process_instruction(index, intcode)
  end
  def process_instruction([99 | _tail], _index, intcode), do: intcode
  def process_instruction([1, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, Enum.at(intcode, a) + Enum.at(intcode, b))
      |> process_instruction(index + 4)
  end
  def process_instruction([101, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, a + Enum.at(intcode, b))
      |> process_instruction(index + 4)
  end
  def process_instruction([1001, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, Enum.at(intcode, a) + b)
      |> process_instruction(index + 4)
  end
  def process_instruction([1101, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, a + b)
      |> process_instruction(index + 4)
  end
  def process_instruction([2, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, Enum.at(intcode, a) * Enum.at(intcode, b))
      |> process_instruction(index + 4)
  end
  def process_instruction([102, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, a * Enum.at(intcode, b))
      |> process_instruction(index + 4)
  end
  def process_instruction([1002, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, Enum.at(intcode, a) * b)
      |> process_instruction(index + 4)
  end
  def process_instruction([1102, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, a * b)
      |> process_instruction(index + 4)
  end
  def process_instruction([3, a | _tail], index, intcode) do
    intcode
      |> List.replace_at(a, system_id)
      |> process_instruction(index + 2)
  end
  def process_instruction([4, a | _tail], index, intcode) do
    intcode
      |> Enum.at(a)
      |> IO.inspect
    process_instruction(intcode, index + 2)
  end
  def process_instruction([104, a | _tail], index, intcode) do
    IO.inspect(a)
    process_instruction(intcode, index + 2)
  end
  def process_instruction([head | _tail], index, intcode) do
    IO.inspect("Unknown opcode: " <> Integer.to_string(head))
    intcode
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