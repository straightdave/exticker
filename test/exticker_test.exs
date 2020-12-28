defmodule MyTicker do
  use ExTicker

  def work() do
    IO.puts("hello")
  end
end

defmodule ExTickerTest do
  use ExUnit.Case
  doctest ExTicker

  test "start ok" do
    MyTicker.start_link([])
    MyTicker.start()
    :timer.sleep(5000)
    MyTicker.stop()
  end
end
