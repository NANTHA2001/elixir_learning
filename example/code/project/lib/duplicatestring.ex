defmodule Repeaterstring do
  def duplicate(string, times) when is_binary(string) do
    String.duplicate(string, times)
  end
end
