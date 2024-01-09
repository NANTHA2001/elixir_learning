square = fn x ->
  IO.puts(x * x)
  end
  square.(5)
#Map
  Enum.map([1, 2, 3], fn x when x > 0 -> IO.puts (x * 2) end)

#Each
  print_element =  fn x  when x > 0 ->  IO.puts(x*2) end
  Enum.each(
    [1, 2, 3],
    &IO.puts/1)

    Enum.each(
    [1, 2, 3],
    print_element)
