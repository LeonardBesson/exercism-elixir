defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      String.ends_with?(input, "?") ->
        "Sure."

      # \p{L} = any Unicode character in category 'Letter'
      input == String.upcase(input) and input =~ ~r/\p{L}/ ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end