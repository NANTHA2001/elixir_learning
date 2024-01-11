defmodule Repeaterlist do
  def duplicate(_, 0) do
    []
  end

  def duplicate("", _), do: ""
  def duplicate(list, times) when is_list(list) do
    list ++ duplicate(list, times - 1)
  end
end
