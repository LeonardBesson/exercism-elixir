defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    (for c <- to_charlist(s), do: <<c :: utf8>>)
    |> get_series(size)
  end

  defp get_series(chars, size) when size <= 0, do: []
  defp get_series(chars, size) when is_list(chars), do: get_series(chars, size, [])
  defp get_series(chars, size, series) when length(chars) < size, do: series |> Enum.reverse
  defp get_series(chars, size, series) do
    new_series = Enum.take(chars, size) |> Enum.join
    get_series(tl(chars), size, [new_series | series])
  end
end

