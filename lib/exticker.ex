defmodule ExTicker do
  @moduledoc """
  Simple Elixir ticker

  Basic usage:
  ```elixir
  defmodule MyWorker do
    use ExTicker, interval: 1000, do: :work

    def work() do
      # .. do some stuff ...
    end
  end
  ```

  Module APIs:
  ```
  MyWorker.start()
  MyWorker.stop()
  ```
  """

  defmacro __using__(opt) do
    intv = Keyword.get(opt, :interval, 1000)
    work_fn = Keyword.get(opt, :do, :work)

    quote do
      use GenServer

      @me __MODULE__

      @interval unquote(intv)
      @work_fn unquote(work_fn)

      @doc """
      start it
      """
      def start() do
        Kernel.send(@me, {:update, :running})
      end

      @doc """
      stop it
      """
      def stop() do
        Kernel.send(@me, {:update, :stopped})
      end

      ########################
      ## implement GenServer
      ##

      def start_link(args) do
        GenServer.start_link(@me, args, name: @me)
      end

      @impl GenServer
      def init(_) do
        {:ok, :init}
      end

      @impl GenServer
      def handle_info({:work}, state) when state == :running do
        apply(@me, @work_fn, [])
        Process.send_after(@me, {:work}, @interval)
        {:noreply, state}
      end

      @impl GenServer
      def handle_info({:work}, state) do
        {:noreply, state}
      end

      @impl GenServer
      def handle_info({:update, new_state}, state)
          when state != :running and new_state == :running do
        Process.send_after(@me, {:work}, @interval)
        {:noreply, new_state}
      end

      @impl GenServer
      def handle_info({:update, new_state}, _state) do
        {:noreply, new_state}
      end

      @impl GenServer
      def handle_call(_request, _from, state) do
        {:reply, "meaningless call", state}
      end
    end
  end
end
