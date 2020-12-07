IO.puts "AoC 2020 - Day 7: Handy Haversacks"

defmodule Helpers do
  def find_parent_bags(_rules, []), do: []
  def find_parent_bags(rules, bag) do
    bags = Enum.flat_map(rules, fn rule ->
      [parent, child] = String.split(rule, "contain")
      case String.contains?(child, bag) do 
        true ->[String.replace(parent, ~r/ bag.+/, "")] 
        false -> [] 
      end
    end)

    Enum.concat(bags, Enum.flat_map(bags, fn bag -> 
      Helpers.find_parent_bags(rules, bag)
    end))
  end
end

case File.read("rules.txt") do
  {:ok, contents} ->
    rules = contents
      |> String.split("\n", trim: true)

    my_bag = "shiny gold"

    IO.puts "Part 1"
    Helpers.find_parent_bags(rules, my_bag)
      |> Enum.sort
      |> Enum.dedup
      |> Enum.count
      |> IO.inspect

  {:error, :enoent} -> nil
end