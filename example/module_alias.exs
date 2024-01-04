 #modules alias
 defmodule Sayings.Greetings do
  def basic(name), do:  IO.puts "Hi, #{name}"
end

defmodule ExampleAlias do
  alias Sayings.Greetings, as: Hi #alias is like import we also give specified name for that module by using as:

  def greeting(name), do: Hi.basic(name)
end

# Without alias

defmodule Example do
  def greeting(name), do: Sayings.Greetings.basic(name)
end

Sayings.Greetings.basic("nantha")
Example.greeting("BTC")
