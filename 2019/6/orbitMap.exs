defmodule Helpers do
  def get_planet_list(orbits) do
    orbits
      |> Enum.flat_map(&(&1))
      |> MapSet.new
      |> MapSet.delete("COM")
  end
  
  def get_direct_orbits(orbits) do
    orbits
      |> Enum.group_by(fn [a, _b] -> a end)
      |> Map.to_list
      |> Enum.map(fn {key, value} -> 
        final = value
          |> Enum.flat_map(&(&1))
          |> MapSet.new
          |> MapSet.delete(key)
        {key, final}
      end)
  end

  def get_total_orbits(planets, direct_orbits) do
    planets
      |> Enum.map(&(count_hops("COM", &1, direct_orbits, 0)))
      |> Enum.sum
  end

  def count_hops(root, root, _orbits, hops), do: hops
  def count_hops(root, planet, orbits, hops) do
    {p, _children} = Enum.find(orbits, fn {_planet, children} -> 
      MapSet.member?(children, planet)
    end)
    count_hops(root, p, orbits, hops + 1)
  end

  def get_common_ancestor(direct_orbits, planet1, planet2) do
    planet1_ancestors = get_ancestors(planet1, direct_orbits, [])
    planet2_ancestors = get_ancestors(planet2, direct_orbits, [])
    
    {common_ancestor, _hops} = planet1_ancestors
    |> MapSet.intersection(planet2_ancestors)
    |> MapSet.to_list
    |> Enum.map(&({&1, count_hops("COM", &1, direct_orbits, 0)}))
    |> Enum.sort(fn ({_p1, h1}, {_p2, h2}) -> h1 < h2 end)
    |> List.last

    common_ancestor
  end

  def get_ancestors("COM", _orbits, ancestors), do: MapSet.new(ancestors)
  def get_ancestors(planet, orbits, ancestors) do
    {p, _children} = Enum.find(orbits, fn {_planet, children} -> 
      MapSet.member?(children, planet)
    end)
    get_ancestors(p, orbits, ancestors ++ [p])
  end
end

IO.puts "AoC 2019 - Day 6: Universal Orbit Map"

case File.read("localOrbits.txt") do
  {:ok, contents} ->
    orbits = contents
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, ")", trim: true)))

    planets = Helpers.get_planet_list(orbits)
    direct_orbits = Helpers.get_direct_orbits(orbits)
    
    IO.inspect(Helpers.get_total_orbits(planets, direct_orbits))

    common_ancestor = Helpers.get_common_ancestor(direct_orbits, "YOU", "SAN")
    hops_for_you = Helpers.count_hops(common_ancestor, "YOU", direct_orbits, 0)
    hops_for_santa = Helpers.count_hops(common_ancestor, "SAN", direct_orbits, 0)
    IO.inspect(hops_for_you + hops_for_santa - 2)
    
  {:error, :enoent} -> nil
end