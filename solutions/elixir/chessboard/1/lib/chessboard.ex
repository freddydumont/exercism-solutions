defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    rank_range() |> Range.to_list()
  end

  def files do
    file_range() |> Range.to_list() |> to_string() |> String.split("", trim: true)
  end
end
