# addind sum of the list head with tail recursive
# tail recursive is like a recursion function that call itself at very end
defmodule AddingSum do
  def sum(list), do: do_sum(0,list)

  defp do_sum(sum,[]), do: IO.puts(sum)

  defp do_sum(sum,[ head |tail]) do
    sum = head + sum
    do_sum(sum,tail)
  end
end


AddingSum.sum([1,2,3])


# print the number in between from ,to
defmodule RangeFromTo do
  def range(from, to) when from <= to, do: do_range(from, to, [])

  defp do_range(to, to, acc) do
     [to | acc]
     |> IO.inspect()
  end

  defp do_range(from, to, acc), do: do_range(from, to-1, [to| acc])
end



RangeFromTo.range(3,7)
