defmodule Todo.ListTest do
  use ExUnit.Case
  doctest Todo.List

  test "the list can be filled" do

    todos = Todo.List.new
        |> Todo.List.add_entry(TodoEntry.new({2016, 2, 1}, "Dentist"))
        |> Todo.List.add_entry(TodoEntry.new({2016, 1, 11}, "Shop"))
        |> Todo.List.add_entry(TodoEntry.new({2016, 1, 10}, "Band"))
        |> Todo.List.add_entry(TodoEntry.new({2016, 2, 1}, "Work"))
        |> Todo.List.add_entry({2016, 3, 3}, "Work")

    febFirstEntries =
        Todo.List.entries(todos, {2016, 2, 1})
            |> Enum.map(fn(e) -> e.title end)

    assert Enum.any?(febFirstEntries, fn(title) -> title == "Dentist" end)
    assert Enum.any?(febFirstEntries, fn(title) -> title == "Work" end)

    janEntries =
        Todo.List.entries(todos, {2016, 1})
            |> Enum.map(fn(e) -> e.title end)

    assert Enum.any?(janEntries, fn(title) -> title == "Shop" end)
    assert Enum.any?(janEntries, fn(title) -> title == "Band" end)
  end
end
