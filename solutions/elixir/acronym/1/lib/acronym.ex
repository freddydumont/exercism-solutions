defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    # Replace all punctuation (except hyphens and apostrophes) with spaces
    |> String.replace(~r/[^\w\s-']|[_]/u, " ")
    # Split on one or more spaces or hyphens
    |> String.split(~r/[\s-]+/)
    # Remove empty strings
    |> Enum.reject(&(&1 == ""))
    |> Enum.map_join(&(&1 |> String.at(0) |> String.capitalize()))
  end
end
