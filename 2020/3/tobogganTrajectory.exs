IO.puts "AoC 2020 - Day 3: Toboggan Trajectory"

case File.read("map.txt") do
  {:ok, contents} ->
    rows = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.split(&1, "", trim: true)))

    IO.puts "Part 1"
    rows
      |> Enum.with_index
      |> Enum.map(fn {row, index} ->
        position = index * 3
        extra_cols =  Kernel.ceil((position + 1) / Enum.count(row))

        row
          |> List.duplicate(extra_cols)
          |> Enum.concat
          |> Enum.at(position)

      end)
      |> Enum.count(&(&1 == "#"))
      |> IO.inspect

    # IO.puts "Part 2 1,1"
    # rows
    #   |> Enum.with_index
    #   |> Enum.map(fn {row, index} ->

    #     row
    #       |> List.duplicate(80) #make dynamic
    #       |> Enum.concat
    #       |> Enum.at(index)

    #   end)
    #   |> Enum.count(&(&1 == "#"))
    #   |> IO.inspect

    # IO.puts "Part 2 5,1"
    # rows
    #   |> Enum.with_index
    #   |> Enum.map(fn {row, index} ->
    #     position = index * 5

    #     row
    #       |> List.duplicate(80) #make dynamic
    #       |> Enum.concat
    #       |> Enum.at(position)

    #   end)
    #   |> Enum.count(&(&1 == "#"))
    #   |> IO.inspect

    # IO.puts "Part 2 7,1"
    # rows
    #   |> Enum.with_index
    #   |> Enum.map(fn {row, index} ->
    #     position = index * 7

    #     row
    #       |> List.duplicate(80) #make dynamic
    #       |> Enum.concat
    #       |> Enum.at(position)

    #   end)
    #   |> Enum.count(&(&1 == "#"))
    #   |> IO.inspect

    # IO.puts "Part 2 1,2"
    # rows
    #   |> Enum.with_index
    #   |> Enum.map(fn {row, index} ->
    #     case Integer.mod(index, 2) do
    #       1 -> "nope"
    #       0 -> row
    #             |> List.duplicate(80) #make dynamic
    #             |> Enum.concat
    #             |> Enum.at(Kernel.round(index / 2))
    #     end

    #   end)
    #   |> Enum.count(&(&1 == "#"))
    #   #|> Enum.count(&(&1 == nil))
    #   |> IO.inspect

    #   IO.inspect(276 * 100 * 85 * 90 * 37)

  {:error, :enoent} -> nil
end