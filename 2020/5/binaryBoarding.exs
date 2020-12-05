IO.puts "AoC 2020 - Day 3: Binary Boarding"

case File.read("seats.txt") do
  {:ok, contents} ->
    seats = contents
      |> String.split("\n", trim: true)

    total_rows = 127
    total_cols = 7

    IO.puts "Part 1"
    seats
      |> Enum.map(fn seat ->
        {row, _, col, _} = seat
          |> String.split("", trim: true)
          |> Enum.reduce({0, total_rows, 0, total_cols}, fn half, {min_row, max_row, min_col, max_col} ->
            case half do
              "B" -> {max_row - floor((max_row - min_row) / 2), max_row, min_col, max_col}
              "F" -> {min_row, floor((max_row - min_row) / 2) + min_row, min_col, max_col}
              "R" -> {min_row, max_row, max_col - floor((max_col - min_col) / 2), max_col}
              "L" -> {min_row, max_row, min_col, floor((max_col - min_col) / 2) + min_col}
            end
          end)
        row * 8 + col
      end)
      |> Enum.max
      |> IO.inspect

    IO.puts "Part 2"
    actual_seats = seats
      |> Enum.map(fn seat ->
        {row, _, col, _} = seat
          |> String.split("", trim: true)
          |> Enum.reduce({0, total_rows, 0, total_cols}, fn half, {min_row, max_row, min_col, max_col} ->
            case half do
              "B" -> {max_row - floor((max_row - min_row) / 2), max_row, min_col, max_col}
              "F" -> {min_row, floor((max_row - min_row) / 2) + min_row, min_col, max_col}
              "R" -> {min_row, max_row, max_col - floor((max_col - min_col) / 2), max_col}
              "L" -> {min_row, max_row, min_col, floor((max_col - min_col) / 2) + min_col}
            end
          end)
        row * 8 + col
      end)
      |> Enum.sort
      
      Enum.min(actual_seats)..Enum.max(actual_seats)
        |> MapSet.new
        |> MapSet.difference(MapSet.new(actual_seats))
        |> MapSet.to_list
        |> List.first
        |> IO.inspect
    
  {:error, :enoent} -> nil
end