
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

#basic abstraction

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
    Enum.each(entries, &IO.puts(&1)) #&capture operator
  end
end

ToDoList.addlist()

#composing abstraction is from creating one abstration on top of another.


defmodule MultiDict do
  def new(), do: ToDoList.addlist()

  # entry = %{date: ~D[2018-12-19], title: "Dentist"}
  def add_entry(todo_list, date, title) do
    ToDoList.add_entry(todo_list, date, title)
  end
  def entries(todo_list, date) do
    ToDoList.entries(todo_list, date)
  end
  end

  # MultiDict.new() # i call this but it will print previous code example this is called composing abstraction


  #generating ids

  defmodule GenerateId do
    # Define a struct named GenerateId with two fields: auto_id and entries.
    defstruct auto_id: 1, entries: %{}

    # Define a function named id
    def id do
      # Create an instance of the GenerateId struct and populate its entries.
      todo_list =
        %GenerateId{}
        |> add_entry_id(%{date: ~D[2024-01-05], title: "dentist"})
        |> add_entry_id(%{date: ~D[2024-02-01], title: "shopping"})
        |> add_entry_id(%{date: ~D[2024-01-05], title: "movie"})


      # Update an entry (for example, by changing the title) by providing the entry's ID
       updated_todo_list = update_entry_id(todo_list, 1, fn entry -> Map.put(entry, :title, "new title") end)
       new_entry = %{id: 1, date: ~D[2024-01-05], title: "updated title"}
       updated_todo_list = update_entry(todo_list, new_entry)

      # Filter entries for a specific date and print them.
      entries = entries_id(updated_todo_list, ~D[2024-01-05])
      print_entries(entries)
    end

    # Define a function to add an entry to the todo list.
    def add_entry_id(todo_list, entry) do
      # Add an id to the entry and update the entries in the todo_list.
      entry_with_id = Map.put(entry, :id, todo_list.auto_id)
      new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry_with_id)

      # Create a new instance of GenerateId with updated entries and auto_id.
      %GenerateId{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
    end

    # Define a function to retrieve entries for a specific date.
    def entries_id(todo_list, date) do
      # Filter entries in the todo_list based on the provided date.
      todo_list.entries
      |> Enum.filter(fn {_, entry} -> entry.date == date end)
      |> Enum.map(fn {_, entry} -> entry end)
    end

     # Define a function to update an entry in the todo list.
  def update_entry_id(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list  # No entry — returns the unchanged list
      {:ok, old_entry} ->
        # Entry exists — performs the update
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, entry_id, new_entry)
        %GenerateId{todo_list | entries: new_entries}
    end
  end

  #two arity function
  def update_entry(todo_list, %{} = new_entry) do
    update_entry_id(todo_list, new_entry.id, fn _ -> new_entry end)
  end

   # Define a function to delete an entry from the todo list by its ID.
   def delete_entry(todo_list, entry_id) do
    case Map.delete(todo_list.entries, entry_id) do
      {:ok, _deleted_entry} ->
        %GenerateId{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
      :error ->
        todo_list  # No entry found, return the unchanged list
    end
  end


    # Define a helper function to print entries.
    defp print_entries(entries) do
      # Print each entry's ID, Title, and Date using IO.puts.
      Enum.each(entries, &IO.puts("ID: #{&1.id}, Title: #{&1.title}, Date: #{&1.date}"))
    end
  end

  # Invoke the id function to demonstrate its functionality.
  GenerateId.id()
