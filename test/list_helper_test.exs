defmodule ListHelperTest do
  use ExUnit.Case
  doctest ListHelper

  import ListHelper

  test "the sum" do
    assert sum([1,2,3]) == 6
  end

  test "the length" do
    assert len([]) == 0
    assert len([1,2,3,4]) == 4
    assert len([1,2,3,4]) == 4
  end

  test "the range" do
    assert range(1, 5) == [1,2,3,4,5]
    assert range(4, 5) == [4,5]
    assert range(4, 1) == [4,3,2,1]
    assert range(-4, 1) == [-4,-3,-2,-1,0,1]
  end

  test "anonym fn with pattern" do
    col = [{"first_a", "first_b"},{"second_a", "second_b"}]
    res = Enum.reduce(col, "text", fn(el, txt) ->
        e1 = elem(el, 0)
        e2 = elem(el, 1)

        e1 <> " " <> e2 <> " " <> txt
    end)

    IO.puts(res)

    res = Enum.reduce(col, "text", fn({e1, e2}, txt) ->

        e1 <> " " <> e2 <> " " <> txt
    end)

    IO.puts(res)
  end
end
