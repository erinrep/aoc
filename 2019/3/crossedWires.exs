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

    {{x, y + distance}, List.insert_at(wire, -1, line)}
  end
  def add_line({{x, y}, wire}, {"R", distance}) do
    line = x..distance + x
      |>Enum.map(&({&1, y}))

    {{x + distance, y}, List.insert_at(wire, -1, line)}
  end
  def add_line({{x, y}, wire}, {"D", distance}) do
    line = y - distance..y
      |>Enum.map(&({x, &1}))
      |>Enum.reverse

    {{x, y - distance}, List.insert_at(wire, -1, line)}
  end
  def add_line({{x, y}, wire}, {"L", distance}) do
    line = x - distance..x
      |>Enum.map(&({&1, y}))
      |>Enum.reverse

    {{x - distance, y}, List.insert_at(wire, -1, line)}
  end

  def make_wire(start, directions) do
    {_last, final} = directions
      |> Enum.reduce({start, []}, fn direction, acc -> 
        Helpers.add_line(acc, direction)
      end)

    final
  end

  def get_coords(wire) do
    Enum.reduce(wire, MapSet.new, fn line, acc -> 
      line
        |> MapSet.new
        |> MapSet.union(acc)
    end)
  end

  def get_intersections(central_port, a_wire, b_wire) do    
    a_coords = get_coords(a_wire)
    b_coords = get_coords(b_wire)

    a_coords
      |> MapSet.intersection(b_coords)
      |> MapSet.delete(central_port)
  end

  def closest_manhattan_distance({offset_x, offset_y}, intersections) do
    intersections
      |> Enum.map(fn {x, y} -> 
        Kernel.abs(x - offset_x) + Kernel.abs(y - offset_y)
      end)
      |> Enum.min
  end

  def steps_to_point(destination, wire) do
    wire
      |> Stream.take_while(&(destination != &1))
      |> Enum.count
  end

  def min_steps(central_port, a_wire, b_wire) do
    a = Enum.reduce(a_wire, [], fn line, acc -> 
      acc ++ Enum.drop(line, -1)
    end)
    b = Enum.reduce(b_wire, [], fn line, acc -> 
      acc ++ Enum.drop(line, -1)
    end)

    central_port
      |> get_intersections(a_wire, b_wire)
      |> Enum.map(&(steps_to_point(&1, a) + steps_to_point(&1, b)))
      |> Enum.min
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

    a_wire = Helpers.make_wire(central_port, a_directions)
    b_wire = Helpers.make_wire(central_port, b_directions)
    intersections = Helpers.get_intersections(central_port, a_wire, b_wire)

    central_port
      |> Helpers.closest_manhattan_distance(intersections)
      |> IO.inspect

    central_port
      |> Helpers.min_steps(a_wire, b_wire)
      |> IO.inspect
    
  {:error, :enoent} -> nil
end