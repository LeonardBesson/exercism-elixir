defmodule ProteinTranslation do
  @rna_table %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    to_charlist(rna) 
      |> Enum.chunk_every(3)
      |> Enum.map(&to_string/1)
      |> get_proteins
  end

  defp get_proteins({:error, _}, _), do: {:error, "invalid RNA"}
  defp get_proteins({:ok, proteins}, []), do: {:ok, proteins |> Enum.uniq |> Enum.reverse}
  defp get_proteins({:ok, proteins}, [codon | tail]) do
    case of_codon(codon) do
      {:ok, "STOP"}  -> get_proteins({:ok, proteins}, [])
      {:error, _}    -> {:error, "invalid RNA"}
      {:ok, protein} -> get_proteins({:ok, [protein | proteins]}, tail)
    end
  end
  defp get_proteins(codons), do: get_proteins({:ok, []}, codons)

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case Map.fetch(@rna_table, codon) do
      {:ok, value} -> {:ok, value}
      :error -> {:error, "invalid codon"}
    end
  end
end

