defmodule Helpers do
  def has_double([a, a, a, a, a, a]), do: true
  def has_double([a, a, a, a, a, _e]), do: true
  def has_double([a, a, a, a, _d, _e]), do: true
  def has_double([a, a, a, _c, _d, _e]), do: true
  def has_double([a, a, _b, _c, _d, _e]), do: true
  def has_double([_a, b, b, b, b, b]), do: true
  def has_double([_a, b, b, b, b, _e]), do: true
  def has_double([_a, b, b, b, _d, _e]), do: true
  def has_double([_a, b, b, _c, _d, _e]), do: true
  def has_double([_a, _b, c, c, c, c]), do: true
  def has_double([_a, _b, c, c, c, _e]), do: true
  def has_double([_a, _b, c, c, _d, _e]), do: true
  def has_double([_a, _b, _c, d, d, d]), do: true
  def has_double([_a, _b, _c, d, d, _e]), do: true
  def has_double([_a, _b, _c, _d, e, e]), do: true
  def has_double(_any), do: false

  def never_decreases(list), do: Enum.sort(list) == list
end

IO.puts "AoC 2019 - 4"

from = 245318
to = 765747

to..from
  |> Enum.map(fn candidate -> 
    parts = candidate
      |> Integer.to_string
      |> String.graphemes
    {
      candidate, 
      Helpers.has_double(parts) && Helpers.never_decreases(parts)
    }
  end)
  |> Enum.filter(fn {_candidate, fits_criteria} -> 
    fits_criteria == true
  end)
  |> Enum.count
  |> IO.inspect