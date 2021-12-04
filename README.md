# Advent of Code Elixir Starter

<!-- MDOC !-->

A template for [Advent of Code](https://adventofcode.com) write in Elixir.

## Usage

First clone this repository and run `mix deps.get`:

    $ git clone https://github.com/ljgago/advent-of-code-elixir-starter aoc-elixir
    $ cd aoc-elixir

    # update or install hex package manager
    $ mix local.hex --force

    # download dependencies
    $ mix deps.get

This template has 3 command that you can use:

    $ mix aoc.gen       # Generate files for Advent of Code
    $ mix aoc.test      # Run the Advent of Code tests from a specific day
    $ mix aoc.run       # Run the specific day of Advent of Code

Its operation is detailed below.

## Generate

You can generate all necesary files for use in the event with a simple
command:

    $ mix aoc.gen day01

This command generate these files:

    Generated advent_of_code app
    * creating lib/advent_of_code/day01.ex
    * creating test/advent_of_code/day01_test.exs
    * creating resources/day01/input.txt
    * creating resources/day01/README.md

- `lib/advent_of_code/day01.ex`: is the module where you write the code.
- `test/advent_of_code/day01_test.exs`: is the module where you write the tests.
- `resources/day01/input.txt`: you can insert here the input data.
- `resources/day01/README.md`: you can write the challenge statement.

If the files already exists, the files doesn't overwrite, are ignored.

## Testing

The tests of every day can be executed individually with the command:

    $ mix aoc.test day01

Or you can run all test with the command (the test run randomly):

    $ mix aoc.test

## Running

For run the code, you can use the follow command:

    $ mix aoc.run day01

In this example, `day01` is the snake case file name generated.

The `AdventOfCode` module implement the `__using__/1` macro importing the
`AdventOfCode.Docs` module used for the `readme/1` function, and use the
behaviour from `AdventOfCode.Adapter` module for force to implement the `run`
function and not forgotten its.

## Config

You can configure the automatic input download from the Advent of Code
session token.

The config can be found in `config/config.ex`

```elixir
config :advent_of_code, :config,
  allow_network?: false,
  year: System.get_env("AOC_YEAR") || default_year.(),
  session: System.get_env("AOC_SESSION") || ""
```

For default, the `allow_network?` is set to `false`, and generate an
empty `input.txt` file.

For dowload the inputs from web, you needs to set the `allow_network?` to `true`
and set the environment var `AOC_SESSION`.

You can to get the session token from the cookie web browser.

No need to define the `AOC_YEAR`, automatically get the year from the OS.

## Docs

You can generate the documentation using [ExDoc](https://github.com/elixir-lang/ex_doc).
Each module reads its `README.md` from `resources` folder.

Happy coding!

[MIT License](LICENSE)
