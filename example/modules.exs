#nested modules
defmodule Modules do
  def morning(name) do
    IO.puts "hello #{name}"
  end

  def evening(name) do
    IO.puts "Good night #{name}."
  end

  #module attributes used for constant values
  @greeting "hello"

  def greeting(name) do
    ~s(#{@greeting} #{name}) #s is sigil change into binaries string
  end


end

Modules.morning "nantha"
Modules.evening "nantha"
 
