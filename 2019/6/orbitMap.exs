IO.puts "AoC 2019 - Day 6: Universal Orbit Map"

defmodule Helpers do
  def total_orbits(orbits) do
    planets = orbits
      |> Enum.flat_map(&(&1))
      |> MapSet.new
      |> MapSet.delete("COM")

    direct_orbits = orbits
      |> Enum.group_by(fn [a, _b] -> a end)
      |> Map.to_list
      |> Enum.map(fn {key, value} -> 
        final = value
          |> Enum.flat_map(&(&1))
          |> MapSet.new
          |> MapSet.delete(key)
        {key, final}
      end)
    
    planets
      |> Enum.map(&(count_hops(&1, direct_orbits, 0)))
      |> Enum.sum
  end

  def count_hops("COM", _orbits, hops), do: hops
  def count_hops(planet, orbits, hops) do
    {p, _children} = Enum.find(orbits, fn {_planet, children} -> 
      MapSet.member?(children, planet)
    end)
    count_hops(p, orbits, hops + 1)
  end
end

case File.read("localOrbits.txt") do
  {:ok, contents} ->
    orbits = contents
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, ")", trim: true)))

    orbits
      |> Helpers.total_orbits
      |> IO.inspect()
    
  {:error, :enoent} -> nil
end