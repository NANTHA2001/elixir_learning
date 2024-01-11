defmodule Recursion.PrintDigits do
  def upto(0), do: 0
  def upto(nums) do
     IO.puts(nums)
     upto(nums-1)  #tail recursion each time call with different value
  end
end
