defmodule RotationalCipher do
  @lowers (for c <- ?a..?z, do: c)
  @uppers (for c <- ?A..?Z, do: c)
  @alphabet @lowers ++ @uppers

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    for c <- to_charlist(text), into: "", do: <<rotate_char(c, shift)>>
  end

  defp rotate_char(c, shift) when (c in @lowers and c + shift > ?z), do: c + shift - 26
  defp rotate_char(c, shift) when (c in @uppers and c + shift > ?Z), do: c + shift - 26
  defp rotate_char(c, shift) when c in @alphabet,                    do: c + shift
  defp rotate_char(c, shift),                                        do: c
end

