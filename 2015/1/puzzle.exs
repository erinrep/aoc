IO.puts "Day 1: Not Quite Lisp"

case File.read("input.txt") do
  {:ok, contents} ->
    directions = contents
      |> String.split("", trim: true)

    floors = directions
    |> Enum.scan(0, fn d, acc ->
      case d do
        "(" -> acc + 1
        _ -> acc - 1
      end
    end)

    floors
    |> List.last()
    |> IO.inspect(label: "Part 1")

    floors
    |> Enum.find_index(&(&1 == -1))
    |> Kernel.+(1)
    |> IO.inspect(label: "Part 2")

  {:error, :enoent} -> nil
end
