defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame, _opts) do
    opacity = if rem(frame, 4) === 0, do: dot.opacity / 2, else: dot.opacity
    %DancingDots.Dot{dot | opacity: opacity}
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init([velocity: v] = opts) when is_number(v), do: {:ok, opts}

  def init(opts),
    do:
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}

  @impl DancingDots.Animation
  def handle_frame(dot, frame, velocity: v) do
    %DancingDots.Dot{dot | radius: dot.radius + (frame - 1) * v}
  end
end
