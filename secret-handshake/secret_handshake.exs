defmodule SecretHandshake do
  use Bitwise

  @handshake_table %{
    1 <<< 0 => "wink",
    1 <<< 1 => "double blink",
    1 <<< 2 => "close your eyes",
    1 <<< 3 => "jump"
  }

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when (code &&& 1 <<< 4) != 0 do
    get_actions(code) |> Enum.reverse
  end
  def commands(code) do
    get_actions(code)
  end

  defp get_actions(code) do
    for {action_mask, action} <- @handshake_table, (code &&& action_mask) != 0, do: action
  end
end

