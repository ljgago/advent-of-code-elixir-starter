defmodule Mix.Tasks.Aoc.Gen do
  use Mix.Task

  @shortdoc "Generate files for Advent of Code"

  @moduledoc """
  Generate files for Advent of Code

  ## Examples

      $ mix aoc.gen day01

  This command generate these files:

      Generated advent_of_code app
      * creating lib/advent_of_code/day01.ex
      * creating test/advent_of_code/day01_test.exs
      * creating resources/day01/input.txt
      * creating resources/day01/README.md

  If the files already exists, the files doesn't overwrite,
  are ignored.

  ## Config

  You can configure the automatic input download from the
  Advent of Code session token.

  The config can be found in `config/config.ex`

      config :advent_of_code, :config,
        allow_network?: false,
        year: System.get_env("AOC_YEAR") || default_year.(),
        session: System.get_env("AOC_SESSION") || ""

  For default, the `allow_network?` is set to `false`,
  and generate an empty `input.txt` file.

  For dowload the inputs from web, you needs to set the
  `allow_network?` to `true` and set the environment var
  `AOC_SESSION`.

  You can to get the session token from the cookie web browser.

  No need to define the `AOC_YEAR`, automatically get the year
  from the OS.
  """

  @impl true
  def run([module_name]) do
    file_name = Macro.underscore(module_name)
    module_name = Macro.camelize(module_name)

    context = %{
      module_name: Module.concat(Elixir, module_name),
      module_fullname: Module.concat(AdventOfCode, module_name),
      module_test: Module.concat(AdventOfCode, module_name <> "Test"),
      file: "lib/advent_of_code/" <> file_name <> ".ex",
      test_file: "test/advent_of_code/" <> file_name <> "_test.exs",
      resource_input: "resources/" <> file_name <> "/input.txt",
      resource_readme: "resources/" <> file_name <> "/README.md"
    }

    input = file_name |> get_resource_input()

    create_file(context.file, EEx.eval_file("priv/templates/aoc.gen/day.ex", context: context))
    create_file(context.test_file, EEx.eval_file("priv/templates/aoc.gen/day_test.ex", context: context))
    create_file(context.resource_input, input)
    create_file(context.resource_readme, EEx.eval_file("priv/templates/aoc.gen/readme.md", context: context))
  end

  defp config, do: Application.get_env(:advent_of_code, :config)
  defp allow_network?, do: Keyword.get(config(), :allow_network?, false)
  defp year, do: Keyword.get(config(), :year)
  defp session, do: Keyword.get(config(), :session)

  defp get_resource_input(file_name) do
    case parse_day(file_name) do
      %{"day" => day} -> get!(String.to_integer(day), year(), session())
      _ -> ""
    end
  end

  defp parse_day(file_name), do: Regex.named_captures(~r/(?<day>\d+)/, file_name)

  defp get!(day, year, session) do
    cond do
      allow_network?() ->
        download!(day, year, session)

      true ->
        ""
    end
  end

  defp download!(day, year, session) do
    %{status: 200, body: body} =
      Tesla.get!(generate_url(day, year), headers: generate_headers(session))

    body
  end

  defp generate_url(day, year), do: "https://adventofcode.com/#{year}/day/#{day}/input"
  defp generate_headers(session), do: [{"cookie", "session=#{session}"}]

  defp create_file(path, content) do
    case File.stat(path) do
      {:ok, _} ->
        log(:yellow, "ignoring", "#{path} already exists", [])
        false

      {:error, _} ->
        Mix.Generator.create_file(path, content)
        true
    end
  end

  defp log(color, command, message, opts) do
    unless opts[:quiet] do
      Mix.shell().info([color, "* #{command} ", :reset, message])
    end
  end
end
