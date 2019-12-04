defmodule Helpers do
  def process_opcode([99 | _tail], intcode), do: intcode
  def process_opcode([1, a, b, c | tail], intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) + Enum.at(intcode, b))
    process_opcode(tail, new_intcode)
  end
  def process_opcode([2, a, b, c | tail], intcode) do
    new_intcode = List.replace_at(intcode, c, Enum.at(intcode, a) * Enum.at(intcode, b))
    process_opcode(tail, new_intcode)
  end
end

IO.puts "AoC 2019 - 2"

case File.read("intcode.txt") do
  {:ok, contents} ->
    intcode = contents
      |> String.split(",", trim: true)
      |> Enum.map(&(String.to_integer(&1)))

    intcode
      |> Helpers.process_opcode(intcode)
      |> List.first
      |> IO.puts
    
  {:error, :enoent} -> nil
end