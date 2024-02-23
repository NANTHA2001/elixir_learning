defmodule JobUpdater do
  def process_job_updates(json_file_path, output_file_path) do
    json_file_path
    |> read_file()
    |> decode_json()
    |> handle_decoding_result(output_file_path)
  end

  defp read_file(json_file_path) do
    case File.read(json_file_path) do
      {:ok, json_data} -> {:ok, json_data}
      {:error, reason} -> {:error, reason}
    end
  end

  defp decode_json({:ok, json_data}) do
    case Jason.decode(json_data) do
      {:ok, decoded_contents} -> {:ok, decoded_contents}
      {:error, reason} -> {:error, reason}
    end
  end

  defp handle_decoding_result({:ok, decoded_contents}, output_file_path) do
    IO.puts "JSON decoded successfully"
    decoded_contents
    |> filter_farm_3_jobs()
    |> calculate_time_difference()
    |> write_latency_to_file(output_file_path)
    IO.puts "Latency data written to #{output_file_path}"
  end

  defp handle_decoding_result({:error, reason}, _) do
    IO.puts "Error decoding JSON content: #{reason}"
  end

  defp filter_farm_3_jobs(decoded_contents) do
    Enum.filter(decoded_contents, &(&1["farm_id"] == 3))
  end

  defp calculate_time_difference(updates) when is_list(updates) do
    updates
    |> handle_empty_updates()
    |> Enum.reduce(%{}, &calculate_job_latency/2)
  end

  defp handle_empty_updates(updates) do
    if Enum.empty?(updates) do
      IO.puts("No updates found.")
      %{}
    else
      updates
    end
  end

  defp calculate_job_latency(update, result) do
    timestamp = parse_iso8601(update["timestamp"])
    update["jobs"]
    |> Enum.reduce(result, &calculate_individual_latency(timestamp, &1, &2))
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

  defp write_latency_to_file(latency_map, output_file_path) do
    new_content =
      for {job_id, latency} <- latency_map do
        "#{job_id}: #{latency} second\n"
      end
      |> Enum.join()

    File.write(output_file_path, new_content)
  end
end

# Example usage:
JobUpdater.process_job_updates("v1_jobs_1h.csv", "latency_output.txt")
