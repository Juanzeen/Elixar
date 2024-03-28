ExUnit.start()

defmodule ChamadaCauda do
  @doc """
  Modificar uma função recursiva (como somatório ou fatorial)
  para usar a otimização de chamada de cauda. Você pode escolher
  qualquer função recursiva, porém você deve escrever de forma
  otimizada para chamada de cauda e também escrever os casos de teste.

  Lembre que "Otimização de Chamada de Cauda" é um método
  aplicado em funções recursivas onde a última instrução
  da funcão é a chamada recursiva, ou seja, a função retorna
  uma chamada para a recursão.
  """
  def run(list) do
    run_aux(list)
  end

  def run_aux([h | t], acc \\0) do
      run_aux(t, h + acc)
   end

  def run_aux([], acc) do
    acc
  end

end

defmodule SomaListaTest do
  use ExUnit.Case, async: true

  test "deve retornar o somatório de todos os elementos da lista" do
    assert ChamadaCauda.run([1, 2, 3]) == 6
    assert ChamadaCauda.run([3, 2, 1]) == 6
    assert ChamadaCauda.run([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 55
  end
end
