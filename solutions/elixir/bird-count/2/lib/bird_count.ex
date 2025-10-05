defmodule BirdCount do
  def today(list) when length(list) == 0, do: nil
  def today(list), do: hd(list)

  def increment_day_count(list) when length(list) == 0, do: [1]
  def increment_day_count([today | tail]), do: [today + 1 | tail]

  def has_day_without_birds?(list), do: 0 in list

  # with folding: `def total(list), do: List.foldl(list, 0, &(&1 + &2))`

  # with recursion
  def total(list, bird_count \\ 0)
  def total([], bird_count), do: bird_count
  def total([head | tail], bird_count), do: total(tail, head + bird_count)

  # with recursion
  def busy_days(list, busy_count \\ 0)
  def busy_days([], busy_count), do: busy_count
  def busy_days([head | tail], busy_count) when head >= 5, do: busy_days(tail, busy_count + 1)
  def busy_days([head | tail], busy_count) when head < 5, do: busy_days(tail, busy_count)

  # with folding (reducing)
  # def busy_days(list) do
  #   List.foldl(
  #     list,
  #     0,
  #     fn birds_seen, busy_count ->
  #       if(birds_seen >= 5, do: busy_count + 1, else: busy_count)
  #     end
  #   )
  # end
end
