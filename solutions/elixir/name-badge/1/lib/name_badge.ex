defmodule NameBadge do
  def print(id, name, department) do
    prefix = if id, do: "[#{id}] - ", else: ""
    suffix = if department, do: "#{String.upcase(department)}", else: "OWNER"

    "#{prefix}#{name} - #{suffix}"
  end
end
