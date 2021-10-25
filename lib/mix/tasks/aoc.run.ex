defmodule Mix.Tasks.Aoc.Run do
  use Mix.Task

  @shortdoc "Run the specific day of Advent of Code"

  @moduledoc """
  Run a specific day of Advent of Code

  ## Examples

      $ mix aoc.run day01
  """

  @impl Mix.Task
  def run([module_name]) do
    module = Module.concat(AdventOfCode, Macro.camelize(module_name))
    apply(module, :run, [])
  end
end
