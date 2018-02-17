defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """
  @spec accumulate(list, (any -> any)) :: list
  def accumulate([], fun), do: []
  def accumulate(list, fun), do: accumulate(list, fun, [])

  def accumulate([head | []], fun, result), do: [fun.(head) | result] |> reverse
  def accumulate([head | tail], fun, result), do: accumulate(tail, fun, [fun.(head) | result])

  defp reverse(list) when is_list(list), do: reverse(list, [])
  defp reverse([], reversed), do: reversed
  defp reverse([head | tail], reversed), do: reverse(tail, [head | reversed])

  # appending + reverse is way faster than lists concatenation for big inputs
end
