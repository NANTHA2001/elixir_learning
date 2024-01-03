defmodule PatternMatch do
  def match do
    greeting = "Hello"

    greet = fn
      # ^ pin operator
      (^greeting, name) -> IO.puts "Hi #{name}"
      (greeting, name) -> IO.puts "#{greeting}, #{name}"
    end

    # Calling the greet function directly inside the match function
    greet.("Hello", "Sean")
    greet.("Mornin'", "Sean")

  end
end


PatternMatch.match()
