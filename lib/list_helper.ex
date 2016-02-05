defmodule ListHelper do

  def sum(list), do: do_sum(0, list)

  defp do_sum(current_sum, []) do
    current_sum
  end

  defp do_sum(current_sum, [head | tail]) do
    do_sum(head + current_sum, tail)
  end

  def len(list), do: do_len(0, list)

  defp do_len(current_len, []) do
    current_len
  end

  defp do_len(current_len, [_ | tail]) do
    #do_len(current_len + 1, tail)
    current_len + 1
    |> do_len(tail)
  end

  def range(from, to), do: do_range([], to, from)

  defp do_range(res, to, to) do
    [to | res]
  end

  defp do_range(res, from, to) when from < to do
    do_range([from | res], from + 1, to)
  end

  defp do_range(res, to, from) when from < to do
    do_range([to | res], to - 1, from)
  end

  def positive([]) do
    []
  end

  def positive([head | tail]) when head >= 0 do
    [head | positive(tail)]
  end

  def positive([head | tail]) when head < 0 do
    positive(tail)
  end

end
