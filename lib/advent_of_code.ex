defmodule AdventOfCode.Adapter do
  @moduledoc """
  Created a behaviour for force to use the `run/0` function.
  """

  @doc false
  @callback run :: any()
end

defmodule AdventOfCode.Docs do
  @moduledoc """
  Implement the `readme/1` function used for embeded the
  README.md file in elixir docs.
  """

  @doc """
  Used for read the README.md file
  """
  def readme(file_name) do
    file_name
    |> File.read!()
    |> String.split("<!-- MDOC !-->")
    |> Enum.fetch!(1)
  end
end

defmodule AdventOfCode do
  @moduledoc """
  #{ AdventOfCode.Docs.readme("README.md") }
  """

  defmacro __using__(_opts) do
    quote do
      # Import the readme/1 function
      import AdventOfCode.Docs

      # Use the behaviour
      @behaviour AdventOfCode.Adapter
    end
  end
end
