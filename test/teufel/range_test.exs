defmodule Teufel.RangeTest do
  use ExUnit.Case

  test "Range to_string" do
    range = 3..7
    assert "3-7" == to_string(range)
  end
end
