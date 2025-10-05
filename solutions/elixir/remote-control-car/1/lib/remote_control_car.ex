defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%struct{distance_driven_in_meters: distance})
      when struct == RemoteControlCar,
      do: "#{distance} meters"

  def display_battery(remote_car)
      when remote_car.__struct__ == RemoteControlCar,
      do: do_display_battery(remote_car)

  defp do_display_battery(remote_car) when remote_car.battery_percentage == 0, do: "Battery empty"
  defp do_display_battery(remote_car), do: "Battery at #{remote_car.battery_percentage}%"

  def drive(remote_car)
      when remote_car.__struct__ == RemoteControlCar,
      do: do_drive(remote_car)

  defp do_drive(remote_car) when remote_car.battery_percentage == 0, do: remote_car

  defp do_drive(remote_car),
    do: %RemoteControlCar{
      remote_car
      | battery_percentage: remote_car.battery_percentage - 1,
        distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
end
