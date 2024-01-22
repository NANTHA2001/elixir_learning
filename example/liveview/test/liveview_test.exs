defmodule LiveviewTest do
  use ExUnit.Case
  doctest Liveview

  test "greets the world" do
    assert Liveview.hello() == :world
  end
end
