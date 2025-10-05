defmodule Username do
  def sanitize(_username, sanitized \\ ~c"")

  def sanitize([], sanitized), do: sanitized

  def sanitize([codepoint | tail], sanitized) do
    case codepoint do
      valid when codepoint == 95 or (codepoint >= 97 and codepoint <= 122) ->
        sanitize(tail, sanitized ++ [valid])

      _ae when codepoint == 228 ->
        sanitize(tail, sanitized ++ ~c"ae")

      _oe when codepoint == 246 ->
        sanitize(tail, sanitized ++ ~c"oe")

      _ue when codepoint == 252 ->
        sanitize(tail, sanitized ++ ~c"ue")

      _ss when codepoint == 223 ->
        sanitize(tail, sanitized ++ ~c"ss")

      _ ->
        sanitize(tail, sanitized)
    end
  end
end
