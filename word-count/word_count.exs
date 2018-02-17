defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> sanitize
    |> split_sentence
    |> count_words
  end

  defp sanitize(sentence), do: Regex.replace(~r/[^-\w\s]/u, sentence, "") |> String.downcase

  defp split_sentence(sentence), do: String.split(sentence, ~r/[_\s]/, [trim: true])

  defp count_words(words) when is_list(words) do
    List.foldl(words, %{}, fn word, word_count ->
      Map.update(word_count, word, 1, &(&1 + 1))
    end)
  end
end
