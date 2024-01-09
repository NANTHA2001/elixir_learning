# Polymorphism with protocols
# Polymorphism is a runtime decision about which code to execute, based on the nature
# of the input data.

defimpl Collectable, for: MapSet do
  def into(map_set) do
    collector_fun = fn
      map_set_acc, {:cont, elem} ->
        MapSet.put(map_set_acc, elem)

      map_set_acc, :done ->
        map_set_acc

      map_set_acc, :halt ->
        :ok
    end

    initial_acc = map_set

    {initial_acc, collector_fun}
  end
end

IO.inspect Enum.into([1, 2, 3], MapSet.new())
