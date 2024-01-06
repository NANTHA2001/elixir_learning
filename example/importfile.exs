defmodule TodoList do
  defstruct entries: []

  def new(entries) do
    %TodoList{entries: entries}
  end
end

defmodule TodoList.CsvImporter do
  def import(file_path) do
    {:ok, file_content} = File.read(file_path)

    parsed_entries =
      file_content
      |> String.split("\n")
      |> Enum.reject(&String.trim(&1) == "")  # Remove empty lines
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(&parse_entry/1)

    TodoList.new(parsed_entries)
  end

  defp parse_entry([date_str, title]) do
    [year, month, day] =
      date_str
      |> String.split("/")
      |> Enum.map(&String.to_integer/1)

    {{year, month, day}, title}
  end
end


todo_list = TodoList.CsvImporter.import("todos.csv")
IO.inspect(todo_list.entries)
