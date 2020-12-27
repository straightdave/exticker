defmodule MyTicker do
  use ExTicker, init_wait: 0, interval: 1000, do: :work

  def work() do
    :ok
  end
end

defmodule ExTickerTest do
  use ExUnit.Case
  doctest ExTicker

  test "do ok" do
    assert MyTicker.work() == :ok
  end
end
