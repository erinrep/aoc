IO.puts "AoC 2020 - Day 2: Passport Processing"

case File.read("passports.txt") do
  {:ok, contents} ->
    passports = contents
      |> String.split("\n\n", trim: true)
      |> Enum.map(&(String.split(&1, ~r{\s})))

    IO.puts "Part 1"
    required_fields = MapSet.new(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
    passports
      |> Enum.map(fn passport ->
        fields = passport
          |> Enum.map(fn fields -> 
            [field, value] = String.split(fields, ":")
            field
          end)
          |> MapSet.new
        MapSet.subset?(required_fields, fields)
      end)
      |> Enum.count(&(&1))
      |> IO.inspect
    
  {:error, :enoent} -> nil
end