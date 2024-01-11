defmodule Recursion.SumDigit do
  def upto(0), do: 0
  def upto(num) do
    num + upto(num-1)
  end
end
