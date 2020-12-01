IO.puts "AoC 2020 - Day 1: Report Repair"
sum_to_find = 2020

case File.read("expenses.txt") do
  {:ok, contents} ->
    expenses = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.to_integer(&1)))

    IO.puts "Part 1"
    expenses
      |> Enum.flat_map(fn expense ->
        case Enum.find(expenses, &(expense + &1 == sum_to_find)) do
          nil -> []
          num -> [num * expense]
        end
      end)
      |> List.first
      |> IO.inspect

    IO.puts "Part 2"
    indexes = expenses
      |> Enum.map(fn expense ->
        Enum.map(expenses, &(expense + &1))
      end)
      |> Enum.with_index
      |> Enum.flat_map(fn {sums, index} ->
        sums
        |> Enum.with_index
        |> Enum.flat_map(fn {sum, inner_index} -> 
          expenses
            |> Enum.map(&({sum + &1, index, inner_index}))
            |> Enum.with_index
        end)
      end)
      |> Enum.find(fn {{sum, _, _}, _} -> 
        sum == sum_to_find
      end)

      {{sum_to_find, a, b}, c} = indexes
      IO.inspect(Enum.at(expenses, a) * Enum.at(expenses, b) * Enum.at(expenses, c))
    
  {:error, :enoent} -> nil
end