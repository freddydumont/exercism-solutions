# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{id: 1, plots: []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1.plots)
  end

  def register(pid, register_to) do
    Agent.cast(pid, fn state ->
      %{
        id: state.id + 1,
        plots: state.plots ++ [%Plot{plot_id: state.id, registered_to: register_to}]
      }
    end)

    Agent.get(pid, fn state -> Enum.find(state.plots, &(&1.plot_id == state.id - 1)) end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{
        id: state.id,
        plots: Enum.reject(state.plots, &(&1.plot_id == plot_id))
      }
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      plot = Enum.find(state.plots, &(&1.plot_id == plot_id))
      if plot, do: plot, else: {:not_found, "plot is unregistered"}
    end)
  end
end
