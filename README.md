# ExTicker

Simple Elixir ticker.

## Basic usage

Defining your ticker:

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

Add your ticker to the supervisor:

```elixir
defmodule MyApp.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {MyApp.MyTicker, []}
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
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
