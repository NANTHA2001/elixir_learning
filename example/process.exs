defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{hello: "world"}) end) #it call loop function with value world
  end

  defp loop(map) do
    receive do
      {:get, key, caller} -> # this only call when it is :get with map value of line three
        send(caller, Map.get(map, key))
        loop(map)
      {:put, key, value} -># this only call when it is :put function and update the map value new value
        loop(Map.put(map, key, value))
    end
  end

  def handle_get_response do
    {:ok, pid} = start_link()
    IO.puts("PID: #{inspect(pid)}") #{:ok, pid} = start_link(): Initiates the KV process and retrieves the process ID (pid).
    send(pid, {:get, :hello, self()})

    receive do
      value ->
        IO.puts("Received before put: #{inspect(value)}")
        send(pid, {:put, :hello, :hi})

        receive do
          updated_value ->
            IO.puts("Received after put: #{inspect(updated_value)}")
        after
          5000 ->  # Timeout after 5 seconds (adjust as needed)
            IO.puts("Timeout: Did not receive updated value within 5 seconds")
        end
    end
  end
end

KV.handle_get_response()
