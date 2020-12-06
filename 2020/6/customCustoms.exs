IO.puts "AoC 2020 - Day 3: Binary Boarding"

case File.read("answers.txt") do
  {:ok, contents} ->
    answers = contents
      |> String.split("\n\n", trim: true)

    IO.puts "Part 1"
    answers
      |> Enum.map(fn answer ->
        answer
          |> String.split("\n", trim: true)
          |> Enum.flat_map(&(String.split(&1, "", trim: true)))
          |> Enum.uniq
          |> Enum.count
      end)
      |> Enum.sum
      |> IO.inspect
    
  {:error, :enoent} -> nil
end