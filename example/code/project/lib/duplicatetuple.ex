# defmodule Repeatertuple do
#   def duplicate(tuple, times) when is_tuple(tuple) do
#     tuple
#     |> Tuple.to_list()
#     |> Repeatertuple.duplicate(times)
#     |> List.to_tuple()
#   end
# end
