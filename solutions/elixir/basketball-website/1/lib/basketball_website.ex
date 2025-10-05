defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    case String.split(path, ".") do
      [hd] -> data[hd]
      [hd | tail] -> extract_from_path(data[hd], Enum.join(tail, "."))
    end
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
