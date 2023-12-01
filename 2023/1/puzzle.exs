IO.puts("Day 1: Trebuchet?!")

case File.read("input.txt") do
  {:ok, contents} ->
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.scan(~r/[0-9]/, line)
      |> Enum.flat_map(& &1)
    end)
    |> Enum.map(&String.to_integer(Enum.at(&1, 0) <> Enum.at(&1, -1)))
    |> Enum.sum()
    |> IO.inspect(label: "Part 1")

    nums = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }

    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.scan(~r/(?=([0-9]|one|two|three|four|five|six|seven|eight|nine))/, line)
      |> Enum.flat_map(& &1)
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&Map.get(nums, &1, &1))
    end)
    |> Enum.map(&String.to_integer(Enum.at(&1, 0) <> Enum.at(&1, -1)))
    |> Enum.sum()
    |> IO.inspect(label: "Part 2")

  {:error, :enoent} ->
    nil
end
