defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten(ll), do: flatten(ll, [])
  def flatten([], acc), do: acc
  def flatten([head | tail], acc) when is_list(head), do: flatten(head, flatten(tail, acc))
  def flatten([nil | tail], acc), do: flatten(tail, acc)
  def flatten([head | tail], acc), do: [head | flatten(tail, acc)]
end
