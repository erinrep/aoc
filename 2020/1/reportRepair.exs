IO.puts "AoC 2020 - Day 1: Report Repair"
sum_to_find = 2020

case File.read("expenses.txt") do
  {:ok, contents} ->
    expenses = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.to_integer(&1)))

    expenses
      |> Enum.flat_map(fn expense ->
        case Enum.find(expenses, &(expense + &1 == sum_to_find)) do
          nil -> []
          num -> [num * expense]
        end
      end)
      |> List.first
      |> IO.inspect
    
  {:error, :enoent} -> nil
end