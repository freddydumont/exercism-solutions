defmodule Username do
  def sanitize([]), do: []

  def sanitize([char | tail]) do
    case char do
      valid when char == ?_ or (char >= ?a and char <= ?z) -> [valid]
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> ~c""
    end ++ sanitize(tail)
  end
end
