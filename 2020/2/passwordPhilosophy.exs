IO.puts "AoC 2020 - Day 2: Password Philosophy"

case File.read("passwords.txt") do
  {:ok, contents} ->
    passwords = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.split(&1, ": ")))

    IO.puts "Part 1"
    passwords
      |> Enum.map(fn [pattern, password] ->
        [frequency, letter] = String.split(pattern)
        [min, max] = frequency
          |> String.split("-")
          |> Enum.map(&(String.to_integer(&1)))
        occurrences = password
          |> String.split("", trim: true)
          |> Enum.frequencies()
          |> Map.get(letter, 0)
        min <= occurrences && max >= occurrences
      end)
      |> Enum.count(&(&1))
      |> IO.inspect
    
  {:error, :enoent} -> nil
end