defmodule <%= inspect context.module_fullname %> do
  use AdventOfCode

  @moduledoc """
  #{ readme(<%= inspect context.resource_readme %>) }
  """

  @impl true
  def run do
    {:ok, input} = File.read(<%= inspect context.resource_input %>)

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(_args) do
  end

  def part_two(_args) do
  end
end
