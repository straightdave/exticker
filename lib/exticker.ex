defmodule ExTicker do
  @moduledoc """
  Simple Elixir ticker.

  Basic usage:
  ```elixir
  defmodule MyTicker do
    # must provide 3 options in order:
    # init_wait -> time to start in the beginning (ms)
    # interval  -> interval (ms)
    # do        -> refer to custom function to trigger
    use ExTicker, init_wait: 0, interval: 1000, do: :work

    def work() do
      # .. do some stuff ...

      # returning :ok -> contine ad infinitum
      :ok

      # returning others -> quit, e.g:
      # :quit
    end
  end
  ```
  """

  defmacro __using__(opt) do
    [init_wait: init_w, interval: intv, do: work_fn] = opt

    quote do
      use GenServer

      @me __MODULE__

      @init_wait unquote(init_w)
      @interval unquote(intv)
      @work_fn unquote(work_fn)

      @doc """
      print current module name
      """
      def whoami() do
        @me
      end

      @doc """
      print opts
      """
      def opts() do
        %{
          :init_wait => @init_wait,
          :interval => @interval,
          :work_fn => @work_fn
        }
      end

      @doc """
      invoke work function (pointed by :do) once
      """
      def invoke(args) do
        apply(@me, @work_fn, args)
      end

      def start_link(args) do
        GenServer.start_link(@me, args, name: @me)
      end

      @impl GenServer
      def init(arg) do
        :timer.sleep(@init_wait)
        schedule()
        {:ok, arg}
      end

      @impl GenServer
      def handle_info({:work}, state) do
        case invoke([]) do
          :ok ->
            schedule()

          _ ->
            nil
        end

        {:noreply, state}
      end

      def schedule() do
        Process.send_after(@me, {:work}, @interval)
      end

      @impl GenServer
      def handle_call(_request, _from, state) do
        {:reply, "meaningless call", state}
      end
    end
  end
end
