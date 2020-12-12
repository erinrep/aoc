IO.puts "AoC 2020 - Day 10: Adapter Array"

case File.read("adapters.txt") do
  {:ok, contents} ->
    adapters = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.to_integer(&1)))

    IO.puts "Part 1"
    max = Enum.max(adapters) + 3
    adapter_map = adapters
      |> Enum.map(&({&1, &1}))
      |> Map.new
      |> Map.put(0, 0)
      |> Map.put(max, max)

    diffs = 0..max
      |> Enum.map(&(Map.get(adapter_map, &1)))
      |> Enum.chunk_by(&(&1 != nil))

    diff_1 = diffs
      |> Enum.map(fn diff -> 
        case diff do
          [_x] -> 0
          [nil | _] -> 0
          _ -> Enum.count(diff) - 1
        end
      end)
      |> Enum.sum

    diff_3 = Enum.count(diffs, &(&1 == [nil, nil]))

    IO.inspect(diff_1 * diff_3)

  {:error, :enoent} -> nil
end