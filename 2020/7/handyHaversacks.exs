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

  def find_total_bags(_rules, 0), do: 0
  def find_total_bags(rules, {num, bag}) do
    bags = Enum.flat_map(rules, fn rule ->
      [parent, child] = String.split(rule, ~r/contain[s]* /)
      
      case String.contains?(parent, bag) do 
        true -> case child do
                  "no other bags." -> []
                  _ -> child
                        |> String.split(", ")
                        |> Enum.flat_map(fn c -> 
                          [n, b] = Regex.split(~r{ }, String.replace(c, ~r/ bag.+/, ""), parts: 2)
                          [{String.to_integer(n), b}]
                        end)
                end
        false -> [] 
      end
    end)

    num * Enum.reduce(bags, 1, fn bag_with_num, acc -> 
      acc + Helpers.find_total_bags(rules, bag_with_num)
    end)
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

    IO.puts "Part 2"
    rules
      |> Helpers.find_total_bags({1, my_bag})
      |> Kernel.-(1)
      |> IO.inspect

  {:error, :enoent} -> nil
end