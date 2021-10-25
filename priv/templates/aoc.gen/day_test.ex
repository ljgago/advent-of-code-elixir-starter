defmodule <%= inspect context.module_test %> do
  use ExUnit.Case

  import <%= inspect context.module_fullname %>

  test "part one" do
    input = nil
    result = part_one(input)
    assert result == nil
  end

  test "part two" do
    input = nil
    result = part_two(input)
    assert result == nil
  end
end
