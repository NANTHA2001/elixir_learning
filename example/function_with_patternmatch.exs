 #pattern matching with function sum of the lis by calling tail
 defmodule Length do
  def of([]), do: 0

  def of([_ | tail]) do
    1 + of(tail)
  end
end


#calling funtcion
Length.of []
IO.puts("Final Length: #{Length.of([1, 2, 3, 4])}")


#pattern matching
defmodule Greeter1 do
  def hello(%{name: person_name}) do
    IO.puts "Hello, " <> person_name
  end
end

fred = %{
  name: "nantha",
  age: "22",
  favorite_color: "black"
  }

#calling function
Greeter1.hello(fred)
