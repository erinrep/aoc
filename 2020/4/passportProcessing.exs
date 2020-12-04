IO.puts "AoC 2020 - Day 2: Passport Processing"

case File.read("passports.txt") do
  {:ok, contents} ->
    passports = contents
      |> String.split("\n\n", trim: true)
      |> Enum.map(&(String.split(&1, ~r{\s})))

    required_fields = MapSet.new(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

    IO.puts "Part 1"
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

    IO.puts "Part 2"
    eye_colors = MapSet.new(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
    passports
      |> Enum.map(fn passport ->
        fields = passport
          |> Enum.map(fn fields -> 
            [field, value] = String.split(fields, ":")
            value_valid? = case field do
              "byr" -> 
                int_value = String.to_integer(value)
                1920 <= int_value && int_value <= 2002
              "iyr" -> 
                int_value = String.to_integer(value)
                2010 <= int_value && int_value <= 2020
              "eyr" -> 
                int_value = String.to_integer(value)
                2020 <= int_value && int_value <= 2030
              "hgt" ->
                [measurement | units] = String.split(value, ~r/[0-9]+/, [trim: true, include_captures: true])
                int_measurement = String.to_integer(measurement)
                case List.first(units) do
                  "cm" -> 150 <= int_measurement && int_measurement <= 193
                  "in" -> 59 <= int_measurement && int_measurement <= 76
                  _ -> false
                end
              "hcl" -> Regex.match?(~r/^#[0-9 a-f]{6}$/, value)
              "ecl" -> MapSet.member?(eye_colors, value)
              "pid" -> Regex.match?(~r/^[0-9]{9}$/, value)
              "cid" -> true
            end
            if value_valid?, do: field
          end)
          |> MapSet.new
        MapSet.subset?(required_fields, fields)
      end)
      |> Enum.count(&(&1))
      |> IO.inspect
    
  {:error, :enoent} -> nil
end