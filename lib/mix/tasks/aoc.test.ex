defmodule Mix.Tasks.Aoc.Test do
  use Mix.Task

  @shortdoc "Run the Advent of Code tests from a specific day"

  @moduledoc """
  Run the Advent of Code tests from a specific day

  ## Examples

      $ mix aoc.test day01

  Or you also can run all tests (the test run randomly)

  ## Examples

      $ mix aoc.test
  """

  @impl true
  def run(args) do
    Mix.env(:test)

    case length(args) do
      0 -> Mix.Task.run("test", ["--seed" , "0", "--trace", "test/advent_of_code/"])
      1 -> Mix.Task.run("test", ["--seed" , "0", "--trace", "test/advent_of_code/" <> Macro.underscore(List.first(args)) <> "_test.exs"])
      _ -> Mix.raise "you need to specify one only argument or none"
    end
  end
end
