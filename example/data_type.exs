defmodule Data_types do
  def data_types do
    list=[1,2,3,-1,-2,7,8]
    IO.puts(Enum.sum(list))
    #find positive number
    IO.inspect(Enum.filter(list, fn x -> x > 0 end))

    #atom
    {:ok,message}={:ok,"Status 200 ok"}
    IO.puts(message)

    #rest
    "E" <> rest = "Elixir"
    IO.puts(rest)

    #head tail
    [head | tail] = [2,4,3,14]
    IO.puts(head)
    IO.inspect(tail)
    
  end
end

Data_types.data_types()
Data_types
