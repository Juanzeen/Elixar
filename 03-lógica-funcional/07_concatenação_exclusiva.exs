ExUnit.start()

defmodule ConcatenacaoExclusiva do
  @doc """
  Concatena duas listas, excluindo da primeira lista os elementos já presentes na segunda.

  ## Dicas
  - Utilize recursão para percorrer a primeira lista e verificar se um elemento está na segunda lista.
  - Pode ser útil criar uma função auxiliar para verificar se um elemento está contido em uma lista.

  ## Exemplos

      iex> ConcatenacaoExclusiva.run([1, 2, 3], [3, 4, 5])
      [1, 2, 4, 5]

      iex> ConcatenacaoExclusiva.run([], [1, 2, 3])
      [1, 2, 3]
  """
  @spec run(list(any), list(any)) :: list(any)
  #"acabando" os elementos de todas as listas quer dizer que todos já foram checados e que podemos retornar o nosso acumulador
  def run([], [], acc, remove), do: Enum.reverse(acc)

  #caso ja tenha sido feita a checagem da lista 1 e não tenha mais elementos a serem removidos, é só concatenar a lista 2
  def run([], lista2, acc, []) do
    [h | t] = lista2
    run([], t, [h|acc], [])
  end

  #função para quando já tiver conferido todos os elementos da lista1, faço uma comparação da lista2 com a lista de elementos que devem ser removidos
  #caso a função auxiliar retorne que é um elemento removido/duplicado, ele não é adicionado ao acumulador e a lista de elementos removidos se torna sua cauda
  #caso o retorno seja falso, simplesmente adiciono o elemento a lista acumuladora
  def run([], lista2, acc, remove) do
    [h | t] = lista2
    [hd | tl] = remove
    if run_aux(h, remove) == true do
      run([], t, acc, tl)
    else
    run([], t, [h | acc], remove)
    end
end

#primeira função que será executada, nela eu comparo os elementos da lista1 com os elementos da lista2
#usando essa comparação, quando tenho elementos iguais eu não concateno no acumulador e adiciono esse elemento na lista de elementos removidos
  def run(lista1, lista2, acc\\[], remove\\[]) do
    [head | tail] = lista1
    if run_aux(head, lista2) == true do
      run(tail, lista2, acc, Enum.reverse([head | remove]))
    else
      run(tail, lista2, [head | acc], remove)
    end
end

  #função auxiliar usada na comparação para saber se tem ou não um elemento nas duas listas
  #se tiver retorna true, se não tiver retorna false
  defp run_aux(_el, []), do: false
  defp run_aux(el, [hd | tl]) when el != hd, do: run_aux(el, tl)
  defp run_aux(el, [hd | _tl]) when el == hd, do: true

end

defmodule ConcatenacaoExclusivaTest do
  use ExUnit.Case, async: true

  test "concatena listas excluindo elementos repetidos" do
    assert ConcatenacaoExclusiva.run([1, 2, 3], [3, 4, 5]) == [1, 2, 4, 5]
  end

  test "concatena uma lista vazia com uma lista não vazia" do
    assert ConcatenacaoExclusiva.run([], [1, 2, 3]) == [1, 2, 3]
  end
end
