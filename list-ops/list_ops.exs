defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count(list), do: count(list, 0)
  def count([], acc), do: acc
  def count([head | tail], acc), do: count(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse(list), do: reverse(list, [])
  def reverse([], acc), do: acc
  def reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map([], f), do: []
  def map(list, f), do: map(list, f, [])
  def map([], f, acc), do: acc |> reverse
  def map([head | tail], f, acc), do: map(tail, f, [f.(head) | acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f), do: []
  def filter(list, f), do: filter(list, f, [])
  def filter([], f, acc), do: acc |> reverse
  def filter([head | tail], f, acc) do
    case f.(head) do
      true  -> filter(tail, f, [head | acc])
      false -> filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a
  def append(a, b), do: append(reverse(a), reverse(b), [])
  def append([], [], acc), do: acc
  def append(a, [head | tail], acc), do: append(a, tail, [head | acc])
  def append([head | tail], [], acc), do: append(tail, [], [head | acc])

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat(ll), do: concat(ll, [])
  def concat([], acc), do: acc
  def concat([head | tail], acc) when is_list(head), do: concat(head, concat(tail, acc))
  def concat([head | tail], acc), do: [head | concat(tail, acc)]
end
