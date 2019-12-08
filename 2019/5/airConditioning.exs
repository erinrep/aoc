defmodule IntcodeComputer do
  def noun_spot, do: 1
  def verb_spot, do: 2
  # air conditioner unit
  # def system_id, do: 1
  # thermal radiators
  def system_id, do: 5

  def process_instruction(intcode, index) do
    intcode
      |> Enum.drop(index)
      |> process_instruction(index, intcode)
  end
  def process_instruction([99 | _tail], _index, intcode), do: intcode

  def process_instruction([1, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    at_b = Enum.at(intcode, b)
    process_instruction([1101, at_a, at_b, c], index, intcode)
  end
  def process_instruction([101, a, b, c | _tail], index, intcode) do
    at_b = Enum.at(intcode, b)
    process_instruction([1101, a, at_b, c], index, intcode)
  end
  def process_instruction([1001, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    process_instruction([1101, at_a, b, c], index, intcode)
  end
  def process_instruction([1101, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, a + b)
      |> process_instruction(index + 4)
  end

  def process_instruction([2, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    at_b = Enum.at(intcode, b)
    process_instruction([1102, at_a, at_b, c], index, intcode)
  end
  def process_instruction([102, a, b, c | _tail], index, intcode) do
    at_b = Enum.at(intcode, b)
    process_instruction([1102, a, at_b, c], index, intcode)
  end
  def process_instruction([1002, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    process_instruction([1102, at_a, b, c], index, intcode)
  end
  def process_instruction([1102, a, b, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, a * b)
      |> process_instruction(index + 4)
  end

  def process_instruction([3, a | _tail], index, intcode) do
    intcode
      |> List.replace_at(a, IntcodeComputer.system_id)
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

  def process_instruction([5, a, b | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    at_b = Enum.at(intcode, b)
    process_instruction([1105, at_a, at_b], index, intcode)
  end
  def process_instruction([105, a, b | _tail], index, intcode) do
    at_b = Enum.at(intcode, b)
    process_instruction([1105, a, at_b], index, intcode)
  end
  def process_instruction([1005, a, b | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    process_instruction([1105, at_a, b], index, intcode)
  end
  def process_instruction([1105, 0, _b | _tail], index, intcode) do
    process_instruction(intcode, index + 3)
  end
  def process_instruction([1105, _a, b | _tail], _index, intcode) do
    process_instruction(intcode, b)
  end

  def process_instruction([6, a, b | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    at_b = Enum.at(intcode, b)
    process_instruction([1106, at_a, at_b], index, intcode)
  end
  def process_instruction([106, a, b | _tail], index, intcode) do
    at_b = Enum.at(intcode, b)
    process_instruction([1106, a, at_b], index, intcode)
  end
  def process_instruction([1006, a, b | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    process_instruction([1106, at_a, b], index, intcode)
  end
  def process_instruction([1106, 0, b | _tail], _index, intcode) do
    process_instruction(intcode, b)
  end
  def process_instruction([1106, _a, _b | _tail], index, intcode) do
    process_instruction(intcode, index + 3)
  end

  def process_instruction([7, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    at_b = Enum.at(intcode, b)
    process_instruction([1107, at_a, at_b, c], index, intcode)
  end
  def process_instruction([107, a, b, c | _tail], index, intcode) do
    at_b = Enum.at(intcode, b)
    process_instruction([1107, a, at_b, c], index, intcode)
  end
  def process_instruction([1007, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    process_instruction([1107, at_a, b, c], index, intcode)
  end
  def process_instruction([1107, a, b, c | _tail], index, intcode) when a < b do
    intcode
      |> List.replace_at(c, 1)
      |> process_instruction(index + 4)
  end
  def process_instruction([1107, _a, _b, c | _tail], index, intcode) do
      intcode
        |> List.replace_at(c, 0)
        |> process_instruction(index + 4)
  end

  def process_instruction([8, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    at_b = Enum.at(intcode, b)
    process_instruction([1108, at_a, at_b, c], index, intcode)
  end
  def process_instruction([108, a, b, c | _tail], index, intcode) do
    at_b = Enum.at(intcode, b)
    process_instruction([1108, a, at_b, c], index, intcode)
  end
  def process_instruction([1008, a, b, c | _tail], index, intcode) do
    at_a = Enum.at(intcode, a)
    process_instruction([1108, at_a, b, c], index, intcode)
  end
  def process_instruction([1108, a, a, c | _tail], index, intcode) do
    intcode
      |> List.replace_at(c, 1)
      |> process_instruction(index + 4)
  end
  def process_instruction([1108, a, b, c | _tail], index, intcode) when a != b do
    intcode
      |> List.replace_at(c, 0)
      |> process_instruction(index + 4)
  end

  def process_instruction([head | _tail], _index, intcode) do
    IO.inspect("Unknown opcode: " <> Integer.to_string(head))
    intcode
  end

  def process_intcode(intcode) do
    intcode
      |> process_instruction(0, intcode)
      |> List.first
  end
end

IO.puts "AoC 2019 - Day 5: Sunny with a Chance of Asteroids"

case File.read("intcode.txt") do
  {:ok, contents} ->
    intcode = contents
    |> String.split(",", trim: true)
    |> Enum.map(&(String.to_integer(&1)))

    IntcodeComputer.process_intcode(intcode)
    
  {:error, :enoent} -> nil
end