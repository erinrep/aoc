defmodule Helpers do
  def calculate_fuel_requirements(mass) when mass <= 0, do: 0
  def calculate_fuel_requirements(mass) when mass > 0 do
    mass
      |> Integer.floor_div(3)
      |> Kernel.-(2)
      |> calculate_fuel_requirements
      |> Kernel.+(mass)
  end
end

IO.puts "AoC 2019 - Day 1: The Tyranny of the Rocket Equation"

case File.read("masses.txt") do
  {:ok, contents} ->
    contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn mass ->
        mass
        |> String.to_integer
        |> Helpers.calculate_fuel_requirements
        |> Kernel.-(String.to_integer(mass))
      end)
      |> Enum.sum
      |> IO.puts
    
  {:error, :enoent} -> nil
end