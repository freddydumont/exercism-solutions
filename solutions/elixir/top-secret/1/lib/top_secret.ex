defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, [{:when, _, [{name, _, args} | _]} | _]} = ast, acc)
      when op in [:def, :defp] do
    do_decode_secret_message(ast, name, args, acc)
  end

  def decode_secret_message_part({op, _, [{name, _, args} | _]} = ast, acc)
      when op in [:def, :defp] do
    do_decode_secret_message(ast, name, args, acc)
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp do_decode_secret_message(ast, name, args, acc) do
    arity = if is_nil(args), do: 0, else: length(args)
    {ast, [String.slice(to_string(name), 0, arity) | acc]}
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], fn ast, acc -> decode_secret_message_part(ast, acc) end)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
