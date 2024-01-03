defmodule Function do
  def fun do
  # 1.anonymous function
  sum = fn (a, b) -> IO.puts(a + b) end
  #calling funtcion
  sum.(2, 3)


  #2.named function
  defmodule Greeter do
    def hello(name), do: IO.puts "Hello, " <> name
  end
  #calling funtcion
  Greeter.hello("Sean")

  #3.function naming with arity
  defmodule Greeter2 do
    def hello(), do: IO.puts "Hello, hi!"
    def hello(name), do: IO.puts "Hiii, " <> name
    def hello(name1, name2), do: IO.puts "Hello, #{name1} and #{name2}"

  end

  #calling funtcion
  Greeter2.hello()
  Greeter2.hello("nantha")
  Greeter2.hello("nantha", "btc")

  end
end

Function.fun()
