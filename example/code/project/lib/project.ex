defmodule Project do
  @moduledoc """
  Documentation for Project.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Project.hello()
      :world

  """
  def hello do
    :world
  end

  defmodule Recursion.PrintDigit do
    def upto(0), do: [0]  # Base case when the input is 0
    def upto(nums) when nums > 0 do
      [nums | upto(nums - 1)]  # Recursive call to build the list
    end
  end


end

#bypass create for custom plug
# defmodule Clinic.HealthCheck do
#   def ping(urls) when is_list(urls), do: Enum.map(urls, &ping/1)

#   def ping(url) do
#     url
#     |> HTTPoison.get()
#     |> response()
#   end

#   defp response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}
#   defp response({:ok, %{status_code: status_code}}), do: {:error, "HTTP Status #{status_code}"}
#   defp response({:error, %{reason: reason}}), do: {:error, reason}
# end
