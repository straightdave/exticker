# ExTicker

Simple Elixir ticker.

## Basic usage

Defining your periodical worker:

```elixir
defmodule MyWorker do
  # Options:
  # - interval  -> interval (ms), default 1000
  # - do        -> function to trigger, default :work
  use ExTicker, interval: 5000, do: :work

  def work() do
    # .. do some stuff ...
  end
end
```

You create it with:
```elixir
MyWorker.new() # it calls `MyWork.start_link([])` behind.
```
> With this `#start_link(any)` function, *MyWorker* could be started by your supervisor:
>```
>children = [
>  {MyWorker, []}
>]
>
>opts = [strategy: :one_for_one, name: MySupervisor]
>Supervisor.start_link(children, opts)
>```

After creation, you can start / stop it with:
```elixir
MyWorker.start()
# begin to do some thing periodically
MyWorker.stop()
# stopped
MyWorker.start()
# resumed ...
```

### Test it in IEx
```
Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> defmodule My do
...(1)>   use ExTicker
...(1)>   def work() do
...(1)>     IO.puts("hello")
...(1)>   end
...(1)> end
{:module, My,
 <<70, 79, 82, 49, 0, 0, 19, 184, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 1, 204,
   0, 0, 0, 49, 9, 69, 108, 105, 120, 105, 114, 46, 77, 121, 8, 95, 95, 105,
   110, 102, 111, 95, 95, 10, 97, 116, 116, ...>>, {:work, 0}}
iex(2)> My.new()
{:ok, #PID<0.231.0>}
iex(3)> My.start()
{:update, :running}
hello
hello
hello
hello
hello
hello
iex(4)> My.stop()
{:update, :stopped}
iex(5)>
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exticker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exticker, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exticker](https://hexdocs.pm/exticker).
