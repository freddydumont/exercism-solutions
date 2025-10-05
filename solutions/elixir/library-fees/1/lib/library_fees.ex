defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    borrow_time = NaiveDateTime.to_time(datetime)
    noon = Time.new!(12, 0, 0)

    Time.before?(borrow_time, noon)
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime),
      do: Date.add(checkout_datetime, 28),
      else: Date.add(checkout_datetime, 29)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    returned_on = datetime_from_string(return)

    days =
      datetime_from_string(checkout)
      |> return_date()
      |> days_late(returned_on)

    if monday?(returned_on),
      do: floor(days * rate * 0.5),
      else: days * rate
  end
end
