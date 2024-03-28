ExUnit.start()
defmodule OrdenacaoLista do
  @doc """
  Ordena uma lista de inteiros.

  ## Exemplos

      iex> OrdenacaoLista.run([3, 1, 4, 1, 5, 9, 2, 6])
      [1, 1, 2, 3, 4, 5, 6, 9]
  """
  @spec run(list(integer)) :: list(integer)
  #O mecanismo de ordenação implementado foi o quicksort
  #Utilizando sempre o head como pivô e a partir dele usando o filter do Enum para dividir as sublistas da esquerda e direita, que são os numeros
  #menores e maiores que o pivô, respectivamente.
  #Por fim, é feita uma concatenação de todas as listas geradas durante o quicksort, onde primeiro chamamos a função novamente mas com o "lado esquerdo"
  #Depois concatenamos com o pivô e por fim concatenamos novamente com a chamada da função no "lado direito".
  #Conforme ocorre as execuções das funções, a lista vai ser ordenando
  def run([]), do: []
  def run([n]), do: [n]

  def run([head|tail]) do
    left = Enum.filter(tail, &(&1 < head))
    right = Enum.filter(tail, &(&1 >= head))

    run(left) ++ [head] ++ run(right)
  end
end

defmodule OrdenacaoListaTest do
  use ExUnit.Case, async: true

  test "ordena uma lista de inteiros" do
    assert OrdenacaoLista.run([5, 3, 4, 1, 2]) == [1, 2, 3, 4, 5]
  end

  test "ordena uma lista já ordenada" do
    assert OrdenacaoLista.run([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
  end
end
