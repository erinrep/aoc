defmodule Helpers do
  def has_allowed_double([a, a, a, a, a, a]), do: false
  def has_allowed_double([_a, b, b, b, b, _f]), do: false
  def has_allowed_double([a, a, a, a, a, _f]), do: false
  def has_allowed_double([_a, b, b, b, b, b]), do: false
  def has_allowed_double([a, a, a, b, b, b]), do: false

  def has_allowed_double([a, a, a, b, b, _f]), do: true
  def has_allowed_double([a, a, a, _b, c, c]), do: true
  def has_allowed_double([a, a, b, b, b, _f]), do: true
  def has_allowed_double([a, a, _b, c, c, c]), do: true
  def has_allowed_double([_a, b, b, b, c, c]), do: true
  def has_allowed_double([_a, b, b, c, c, c]), do: true

  def has_allowed_double([a, a, a, _d, _e, _f]), do: false
  def has_allowed_double([_a, b, b, b, _e, _f]), do: false
  def has_allowed_double([_a, _b, c, c, c, _f]), do: false
  def has_allowed_double([_a, _b, _c, d, d, d]), do: false
  
  def has_allowed_double([a, a, _b, _c, _d, _f]), do: true
  def has_allowed_double([_a, b, b, _c, _d, _f]), do: true
  def has_allowed_double([_a, _b, c, c, _d, _f]), do: true
  def has_allowed_double([_a, _b, _c, d, d, _f]), do: true
  def has_allowed_double([_a, _b, _c, _d, e, e]), do: true
  def has_allowed_double(_any), do: false

  def never_decreases(list), do: Enum.sort(list) == list
end

IO.puts "AoC 2019 - 4"

245318..765747
  |> Enum.filter(fn candidate -> 
    parts = candidate
      |> Integer.to_string
      |> String.graphemes
    Helpers.never_decreases(parts) && Helpers.has_allowed_double(parts)
  end)
  |> Enum.count
  |> IO.inspect