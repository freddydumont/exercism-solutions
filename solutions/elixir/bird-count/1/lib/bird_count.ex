defmodule BirdCount do
  def today(list) when length(list) == 0, do: nil
  def today(list), do: hd(list)

  def increment_day_count(list) when length(list) == 0, do: [1]
  def increment_day_count([today | tail]), do: [today + 1 | tail]

  def has_day_without_birds?(list), do: 0 in list

  def total(list), do: List.foldl(list, 0, &(&1 + &2))

  def busy_days([]), do: 0

  def busy_days(list) do
    List.foldl(
      list,
      0,
      fn birds_seen, busy_count ->
        if(birds_seen >= 5, do: busy_count + 1, else: busy_count)
      end
    )
  end
end
