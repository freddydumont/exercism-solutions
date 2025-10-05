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

  def handle_frame(dot, frame, _opts) do
    opacity = if Integer.mod(frame, 4) === 0, do: dot.opacity / 2, else: dot.opacity
    %DancingDots.Dot{dot | opacity: opacity}
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  def init(opts) do
    if is_number(opts[:velocity]),
      do: {:ok, opts},
      else:
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}
  end

  def handle_frame(dot, frame, opts) do
    %DancingDots.Dot{dot | radius: dot.radius + (frame - 1) * opts[:velocity]}
  end
end
