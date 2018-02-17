defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/([-\s]|(?=[A-Z]))/)
    |> Enum.map(fn word -> word |> String.slice(0, 1) |> String.upcase end)
    |> Enum.join
  end
end
