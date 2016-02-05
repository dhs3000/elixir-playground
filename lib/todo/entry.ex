defmodule Todo.Entry do
    defstruct id: nil, date: nil, title: nil

    def new(date, title), do: %Todo.Entry{date: date, title: title}

    def withId(%Todo.Entry{} = entry, id) do

    %Todo.Entry{ entry | id: id}
    end
end

defimpl String.Chars, for: Todo.Entry do
  def to_string(todo_entry) do
    "#Todo.Entry<[date: #{date_to_string(todo_entry.date)}, title: #{todo_entry.title}]>"
  end

  defp date_to_string({y, m, d}) do
    "#{y}/#{m}/#{d}"
  end
end