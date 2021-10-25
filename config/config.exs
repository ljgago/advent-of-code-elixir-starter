import Config

default_year = fn ->
  case :calendar.local_time() do
    {{y, 12, _}, _} -> y
    {{y, _, _}, _} -> y - 1
  end
end

config :tesla, adapter: Tesla.Adapter.Mint

config :advent_of_code, :config,
  allow_network?: false,
  year: System.get_env("AOC_YEAR") || default_year.(),
  session: System.get_env("AOC_SESSION") || ""
