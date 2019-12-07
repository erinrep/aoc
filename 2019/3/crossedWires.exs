defmodule Helpers do
  def make_direction_list(path) do 
    path
      |> Enum.map(fn direction -> 
      {letter, number} = String.split_at(direction, 1)
      {letter, String.to_integer(number)}
    end)
  end
  
  def add_line({{x, y}, wire}, {"U", distance}) do
    line = y..distance + y
      |>Enum.map(&({x, &1}))
      |>MapSet.new

    {{x, y + distance}, MapSet.union(wire, line)}
  end
  def add_line({{x, y}, wire}, {"R", distance}) do
    line = x..distance + x
      |>Enum.map(&({&1, y}))
      |>MapSet.new

    {{x + distance, y}, MapSet.union(wire, line)}
  end
  def add_line({{x, y}, wire}, {"D", distance}) do
    line = y - distance..y
      |>Enum.map(&({x, &1}))
      |>MapSet.new

    {{x, y - distance}, MapSet.union(wire, line)}
  end
  def add_line({{x, y}, wire}, {"L", distance}) do
    line = x - distance..x
      |>Enum.map(&({&1, y}))
      |>MapSet.new

    {{x - distance, y}, MapSet.union(wire, line)}
  end

  def make_wire(wire, start, directions) do
    {_last, final} = directions
      |> Enum.reduce({start, wire}, fn direction, acc -> 
        Helpers.add_line(acc, direction)
      end)

    final
  end
end

IO.puts "AoC 2019 - 3"

case File.read("wireBlueprints.txt") do
  {:ok, contents} ->
    [a_directions, b_directions] = contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn directions -> 
        directions
          |> String.split(",", trim: true)
          |> Helpers.make_direction_list
      end)

    central_port = {1, 1}
    {offset_x, offset_y} = central_port

    a_wire = [central_port]
      |> MapSet.new
      |> Helpers.make_wire(central_port, a_directions)

    b_wire = [central_port]
      |> MapSet.new
      |> Helpers.make_wire(central_port, b_directions)

    a_wire
      |> MapSet.intersection(b_wire)
      |> MapSet.delete({1, 1})
      |> Enum.map(fn {x, y} -> 
        Kernel.abs(x - offset_x) + Kernel.abs(y - offset_y)
      end)
      |> Enum.min
      |> IO.inspect
    
  {:error, :enoent} -> nil
end