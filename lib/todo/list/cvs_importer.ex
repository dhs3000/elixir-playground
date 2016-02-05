defmodule Todo.List.CsvImporter do

    def import(filename) do
      lines(filename)
        |> parseDateAndTitles
        |> toEntries
        |> Todo.List.new
    end

    defp lines(filename) do
      File.stream!(filename)
        |> Stream.map(&String.replace_trailing(&1, "\n", ""))
    end

    defp parseDateAndTitles(lines) do
      lines
        |> Stream.map(&parseDateAndTitle/1)
    end

    defp parseDateAndTitle(line) do
      [date, title] =
        line
          |> String.split(",")
          |> Enum.map(&String.strip/1)
      [year, month, day] =
        date
          |> String.split("/")
          |> Stream.map(&String.strip/1)
          |> Enum.map(&String.to_integer/1)
      {{year, month, day}, title}
    end

    defp toEntries(dateAndTitles) do
      dateAndTitles
        |> Stream.map(&toEntry/1)
    end

    defp toEntry({date, title}) do
      Todo.Entry.new(date, title)
    end
end