
defmodule Todo.List do

  defstruct auto_id: 1, entries: HashDict.new

  def new(entries \\ []) do
    Enum.reduce(entries, %Todo.List{}, fn(entry, todo_list) ->
      add_entry(todo_list, entry)
    end)
  end

  def add_entry(%Todo.List{} = todo_list, date, title) do
    add_entry(todo_list, Todo.Entry.new(date, title))
  end

  def add_entry(
    %Todo.List{entries: entries, auto_id: auto_id} = todo_list,
    %Todo.Entry{} = entry
  ) do

    entry = entry |> Todo.Entry.withId(auto_id)
    new_entries = HashDict.put(entries, auto_id, entry)

    %Todo.List{ todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def entries(%Todo.List{entries: entries}, {year, month, day}) do
      entries
        |> find_entries(fn({_, %{date: {ey, em, ed}}}) -> ey == year && em == month && ed == day end)
  end

  def entries(%Todo.List{entries: entries}, {year, month}) do
      entries
        |> find_entries(fn({_, %{date: {ey, em, _}}}) -> ey == year && em == month end)
  end

  defp find_entries(entries, filterFn) do
      entries
        |> Stream.filter(filterFn)
        |> Enum.map(fn({_, entry}) -> entry end)
  end

end

defimpl String.Chars, for: Todo.List do
  def to_string(todo_list) do
    "#Todo.List<[\n  #{entries_to_string(todo_list.entries)}]>"
  end

  defp entries_to_string(entries) do
    entries
      |> Stream.map(fn({_, entry}) -> entry end)
      |> Enum.sort(fn(%{date: {y1, m1, d1}}, %{date: {y2, m2, d2}}) -> y1 < y2 || m1 < m2 || d1 < d2 end)
      |> Stream.map(&Kernel.to_string/1)
      |> Enum.join(",\n  ")
  end
end