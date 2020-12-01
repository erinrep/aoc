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
    expenses
      |> Enum.map(fn expense ->
        Enum.map(expenses, &(expense + &1))
      end)
      |> Enum.flat_map(fn sums ->
        sums
        |> Enum.flat_map(fn sum -> 
          case Enum.find(expenses, &(sum + &1 == sum_to_find)) do
            nil -> []
            num -> [num]
          end
        end)
      end)
      |> Enum.sort
      |> Enum.dedup
      |> Enum.reduce(fn x, acc -> x * acc end)
      |> IO.inspect
    
  {:error, :enoent} -> nil
end