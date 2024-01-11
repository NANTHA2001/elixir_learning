defmodule ProjectTest do
  use ExUnit.Case
  doctest Project
  import ExUnit.CaptureIO


  setup_all do #setup_all run once the test is suite it return a tuple {:ok, state}
    {:ok, recipient: :world} end

    # setup do
    #   bypass = Bypass.open()
    #   {:ok, bypass: bypass}
    # end

    # test "request with HTTP 200 response", %{bypass: bypass} do
    #   Bypass.expect(bypass, fn conn ->
    #     Plug.Conn.resp(conn, 200, "pong")
    #   end)

    #   assert {:ok, "pong"} = HealthCheck.ping("http://localhost:#{bypass.port}")
    # end

  test "greets the world", state do
    assert Project.hello() == state[:recipient]
  end

  test "print_digit" do
    assert Project.Recursion.PrintDigit.upto(3) == [3,2,1,0]
  end

  test "output hello world" do
    assert capture_io(fn -> IO.puts("hello world") end) == "hello world\n"
  end

end


defmodule RepeaterTest do
  use ExUnit.Case

  describe "duplicate/2" do
    test "creates a new string, with the first argument duplicated a specified number of times" do
      assert "aaaa" == Repeaterstring.duplicate("a", 4)
    end
  end
end

defmodule RepeaterTests do
  use ExUnit.Case

  describe "duplicating a string" do
    test "duplicates the first argument a number of times equal to the second argument" do
      assert "aaaa" == Repeaterstring.duplicate("a", 4)
    end

    test "returns an empty string if the first argument is an empty string" do
      assert "" == Repeaterstring.duplicate("", 4)
    end

    test "returns an empty string if the second argument is zero" do
      assert "" == Repeaterstring.duplicate("a", 0)
    end

    test "works with longer strings" do
      alphabet = "abcdefghijklmnopqrstuvwxyz"

      assert "#{alphabet}#{alphabet}" == Repeaterstring.duplicate(alphabet, 2)
    end
  end
end


#streamData

defmodule RepeaterTestss do
  use ExUnit.Case        # Use the ExUnit testing framework
  use ExUnitProperties  # Use ExUnitProperties for property-based testing

  describe "duplicate/2" do  # Start a description block for the "duplicate/2" function
    property "creates a new string, with the first argument duplicated a specified number of times" do
      check all str <- string(:printable),  # Generate a printable string
                times <- integer(),            # Generate an integer
                times >= 0 do                    # Ensure the generated integer is non-negative
        new_string = Repeaterstring.duplicate(str, times)  # Call the `Repeater.duplicate/2` function

        assert String.length(new_string) == String.length(str) * times  # Assert the length of the new string
        assert Enum.all?(String.split(new_string, str), &(&1 == ""))    # Assert that the new string contains only repeated strings
      end
    end
  end
end


defmodule RepeaterTestlist do
  use ExUnit.Case             # Use the ExUnit testing framework
  use ExUnitProperties  # Use ExUnitProperties for property-based testing

  describe "duplicate/2" do  # Start a description block for the `duplicate/2` function
    property "creates a new list, with the elements of the original list repeated a specified number of times" do
      check all list <- list_of(term()),  # Generate a list of any Erlang term
                times <- integer(),             # Generate an integer
                times >= 0 do                     # Ensure the generated integer is non-negative
        new_list = Repeaterlist.duplicate(list, times)  # Call the `Repeater.duplicate/2` function

        assert length(new_list) == length(list) * times  # Assert the length of the new list

        if length(list) > 0 do
          assert Enum.all?(Enum.chunk_every(new_list, length(list)), &(&1 == list))  # Ensure chunks of the new list match the original list
        end
      end
    end
  end
end


# defmodule RepeaterTesttuple do
#   use ExUnit.Case
#   use ExUnitProperties

#   describe "duplicate/2" do
#     property "creates a new tuple, with the elements of the original tuple repeated a specified number of times" do
#       check all t <- tuple({term()}),         # Generate tuples with terms as elements
#                 times <- integer(),           # Generate integers
#                 times >= 0 do                # Ensure times is non-negative
#         result_1 =
#           t
#           |> Repeatertuple.duplicate(times)      # Apply the Repeater.duplicate/2 function to the tuple
#           |> Tuple.to_list()                # Convert the resulting tuple to a list

#         result_2 =
#           t
#           |> Tuple.to_list()                # Convert the original tuple to a list
#           |> Repeatertuple.duplicate(times)      # Duplicate the list

#         assert result_1 == result_2         # Ensure both results are equal
#       end
#     end
#   end
# end





