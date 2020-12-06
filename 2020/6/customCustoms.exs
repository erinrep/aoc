IO.puts "AoC 2020 - Day 6: Custom Customs"

case File.read("answers.txt") do
  {:ok, contents} ->
    groups = contents
      |> String.split("\n\n", trim: true)

    IO.puts "Part 1"
    groups
      |> Enum.map(fn group ->
        group
          |> String.split("\n", trim: true)
          |> Enum.flat_map(&(String.split(&1, "", trim: true)))
          |> Enum.uniq
          |> Enum.count
      end)
      |> Enum.sum
      |> IO.inspect

    IO.puts "Part 2"
    groups
      |> Enum.map(fn group ->
        answers = String.split(group, "\n", trim: true)
        num_in_group = Enum.count(answers)
        answers
          |> Enum.flat_map(&(String.split(&1, "", trim: true)))
          |> Enum.frequencies
          |> Map.to_list
          |> Enum.reduce(0, fn {_q, num}, acc ->
            case num == num_in_group do
              true -> acc + 1
              false -> acc
            end
          end)
      end)
      |> Enum.sum
      |> IO.inspect

  {:error, :enoent} -> nil
end