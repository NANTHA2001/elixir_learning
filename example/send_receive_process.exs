defmodule MessageModule do
  def hello_message do
    parent = self()#get the current pid value

    _spawned_pid =
      spawn(fn ->
        send(parent, {:hello, self()})#spawn is a process import automatically
      end)

    receive do
      {:hello, pid} ->
        "Got hello from #{inspect pid}"
    end
  end
end

IO.puts MessageModule.hello_message
