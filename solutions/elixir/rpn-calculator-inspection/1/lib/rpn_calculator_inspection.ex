defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)

      {:EXIT, ^pid, _} ->
        Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    flag = Process.flag(:trap_exit, true)

    checked =
      Enum.reduce(inputs, %{}, fn input, acc ->
        p = start_reliability_check(calculator, input)
        await_reliability_check_result(p, acc)
      end)

    Process.flag(:trap_exit, flag)

    checked
  end

  def correctness_check(calculator, inputs) do
    Enum.map(inputs, &Task.async(fn -> calculator.(&1) end))
    |> Task.await_many(100)
  end
end
