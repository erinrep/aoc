IO.puts "AoC 2019 - 1"

case File.read("masses.txt") do
  {:ok, contents} ->
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn mass ->
      mass
      |> String.to_integer
      |> Integer.floor_div(3)
      |> Kernel.-(2)
    end)
    |> Enum.sum
    |> IO.puts
  {:error, :enoent} -> nil
end