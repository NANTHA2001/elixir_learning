defmodule VendorTest do
  use ExUnit.Case
  doctest Vendor

  test "greets the world" do
    assert Vendor.hello() == :world
  end
end
