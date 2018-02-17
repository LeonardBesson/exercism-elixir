defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u", "yt", "xr"]
  @consonants ((for c <- ?a..?z, do: <<c>>) -- @vowels) ++ ["ch", "qu", "squ", "th", "thr", "sch"]
  
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    case starts_vowel(word) do
      true ->
        word <> "ay"

      false ->
        consonant = get_consonant(word)
        rest = String.trim_leading(word, consonant)
        rest <> consonant <> "ay"
    end
  end

  defp starts_vowel(word) do
    Enum.any?(@vowels, fn v -> String.starts_with?(word, v) end)
  end

  defp get_consonant(word), do: get_consonant(word, "")
  defp get_consonant(word, consonant) do
    new_cons = List.foldl(@consonants, "", fn c, acc ->
      cond do
        String.starts_with?(word, c) -> c
        
        true -> acc
      end
    end)

    case new_cons do
      "" ->
        consonant

      _  ->
        range = String.length(new_cons)..String.length(word)
        rest = String.slice(word, range)
        get_consonant(rest, consonant <> new_cons)
    end
  end
end

