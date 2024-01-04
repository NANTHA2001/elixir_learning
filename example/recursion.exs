# recursion adding head alone
defmodule Recursion do
  def fun([]), do: 0
  def fun([head |tail]), do: head + fun(tail)
end

# addind sum of the list
defmodule AddingSum do
  def sum([]), do: 0
  def sum([ _ |tail]), do: 1 + sum(tail)
end


IO.puts(Recursion.fun([1,2,3]))
IO.puts AddingSum.sum([1,2,3])


