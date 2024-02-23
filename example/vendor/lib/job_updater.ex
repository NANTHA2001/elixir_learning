defmodule JobUpdater do
  def process_job_updates(json_file_path, output_file_path) do
    json_file_path
    |> File.read()
    |> decode_json()
    |> filter_farm_3_jobs()
    |> calculate_time_difference()
    |> write_latency_to_file(output_file_path)
  end

  defp decode_json({:ok, json_data}), do: {:ok, Jason.decode(json_data)}
  defp decode_json({:error, reason}), do: {:error, reason}

  defp filter_farm_3_jobs({:ok, decoded_contents}) do
    {:ok, Enum.filter(decoded_contents, &(&1["farm_id"] == 3))}
  end
  defp filter_farm_3_jobs({:error, reason}), do: {:error, reason}

  defp calculate_time_difference({:ok, updates}) when is_list(updates) do
    if Enum.empty?(updates) do
      {:ok, %{}}
    else
      {:ok, Enum.reduce(updates, %{}, &calculate_job_latency/2)}
    end
  end
  defp calculate_time_difference({:error, _}), do: {:error, "No updates found."}

  defp calculate_job_latency(update, result) do
    timestamp = parse_iso8601(update["timestamp"])
    Enum.reduce(update["jobs"], result, &calculate_individual_latency(timestamp, &1, &2))
  end

  defp calculate_individual_latency(timestamp, job, result) do
    job_id = job["Id"]
    job_timestamp = parse_iso8601(job["UpdatedAt"])
    time_difference_in_seconds = abs(NaiveDateTime.diff(job_timestamp, timestamp, :second))

    Map.update(result, job_id, time_difference_in_seconds, fn existing_time_difference ->
      if existing_time_difference && existing_time_difference <= time_difference_in_seconds do
        existing_time_difference
      else
        time_difference_in_seconds
      end
    end)
  end

  defp parse_iso8601(timestamp) do
    NaiveDateTime.from_iso8601!(timestamp)
  end

  defp write_latency_to_file({:ok, latency_map}, output_file_path) do
    new_content =
      for {job_id, latency} <- latency_map do
        "#{job_id}: #{latency} second\n"
      end
      |> Enum.join()

    File.write(output_file_path, new_content)
    IO.puts "Latency data written to #{output_file_path}"
  end
  defp write_latency_to_file({:error, reason}, _), do: IO.puts("Error: #{reason}")
end

# Example usage:
JobUpdater.process_job_updates("v1_jobs_1h.csv", "latency_output.txt")
