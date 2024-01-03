#function with guard with private function

defmodule Guard do
  def fun do
    defmodule Greeter do
      def hello(names) when is_list(names) do
        names = Enum.join(names, ", ")

        hello(names)
      end

      def hello(name) when is_binary(name) do
        IO.puts phrase() <> name
      end

      defp phrase, do: "Hello, "
    end

    #calling function
    Greeter.hello ["Sean", "Steve"]

  #default function \\
    defmodule Greeter do
      def hello(name, language_code \\ "en") do
        IO.puts phrase(language_code) <> name
      end

      defp phrase("en"), do: "Hello, "
      defp phrase("es"), do: "Hola, "
    end

    #calling function
    Greeter.hello("Sean", "en")
    Greeter.hello("Sean")
    Greeter.hello("Sean", "es")

  end
end

Guard.fun()
