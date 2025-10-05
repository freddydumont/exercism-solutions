defmodule Username do
  def sanitize(_username, sanitized \\ ~c"")

  def sanitize([], sanitized), do: sanitized

  def sanitize([codepoint | tail], sanitized) do
    case codepoint do
      valid when codepoint == ?_ or (codepoint >= ?a and codepoint <= ?z) ->
        sanitize(tail, sanitized ++ [valid])

      _ae when codepoint == ?ä ->
        sanitize(tail, sanitized ++ ~c"ae")

      _oe when codepoint == ?ö ->
        sanitize(tail, sanitized ++ ~c"oe")

      _ue when codepoint == ?ü ->
        sanitize(tail, sanitized ++ ~c"ue")

      _ss when codepoint == ?ß ->
        sanitize(tail, sanitized ++ ~c"ss")

      _ ->
        sanitize(tail, sanitized)
    end
  end
end
