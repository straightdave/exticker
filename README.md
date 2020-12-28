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
MyWorker.start_link([])
```
> With this `#start_link` function, *MyWorker* could be started by your supervisor:
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
# restarted ...
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
