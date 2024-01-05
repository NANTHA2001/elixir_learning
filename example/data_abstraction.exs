
#modifer function give modified version of the abstraction
#query function give different data type


defmodule Sample do
  def run do
    mapset =
      MapSet.new() #instances the abstraction
      |> MapSet.put(:monday)
      |> MapSet.put(:tuesday) #modify the abstration

    s = MapSet.member?(mapset, :monday)  #query abstration
    IO.puts(s)
  end
end

Sample.run()


#add list with some entries and get the list with specific date
defmodule ToDoList do
  def addlist do
    todo_list =
      %{} # empty maps
      |> add_entry(~D[2024-01-05], "dentist")
      |> add_entry(~D[2024-02-01], "shopping")
      |> add_entry(~D[2024-01-05], "movie")

    s = entries(todo_list, ~D[2024-01-05])
    print_separate_lines(s)
  end

  defp add_entry(todo_list, date, title) do
     Map.update(todo_list, date, [title], fn titles -> [title | titles] end) #[title] is default value that title contain single value associated with list
     #if the date match then only that titles can change the value of current title if date is not match it store default [title]
  end

  defp entries(todo_list, date) do
    Map.get(todo_list, date, "No entries found for #{inspect date}") # if no entries found it print this mes
  end

  defp print_separate_lines(entries) do
    Enum.each(entries, &IO.puts(&1))
  end
end

ToDoList.addlist()
