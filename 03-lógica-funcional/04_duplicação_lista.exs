ExUnit.start()

defmodule DuplicacaoLista do
  @doc """
  Duplica cada elemento de uma lista fornecida.

  ## Dicas
  - Utilize recursão para percorrer a lista e adicionar cada elemento duas vezes na nova lista.

  ## Exemplos

      iex> DuplicacaoLista.run([1, 2, 3])
      [1, 1, 2, 2, 3, 3]

      iex> DuplicacaoLista.run([])
      []
  """
  @spec run(list(any)) :: list(any)
  def run([], acc, reps), do: Enum.reverse(acc)
  def run([h|t], acc, reps) when reps == 2, do: run(t, acc, 0)
  def run([h|t], acc\\[], reps\\0) when reps<2, do: run([h|t], [h | acc], reps+1)

end

defmodule DuplicacaoListaTest do
  use ExUnit.Case, async: true

  test "duplica os elementos de uma lista" do
    assert DuplicacaoLista.run([1, 2, 3]) == [1, 1, 2, 2, 3, 3]
  end

  test "retorna uma lista vazia se a entrada for uma lista vazia" do
    assert DuplicacaoLista.run([]) == []
  end
end
