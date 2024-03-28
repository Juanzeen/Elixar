ExUnit.start()

defmodule Fibonnacci do
  @doc """
  A função de fibonnaci deve receber um inteiro
  e retornar a sequência de fibonnaci como uma lista,
   com o tamanho representado pelo primeiro parâmetro.

  Exemplo: Fibonacci.run(2) # 1 1
  Exemplo: Fibonacci.run(5) # 1 1 2 3 5
  Exemplo: Fibonacci.run(8) # 1 1 2 3 5 8 13 21

  Lembre que a sequência de fibonnacci se dá pela soma
  de um número da sequência somado ao seu antecessor.
  """
  @spec run(integer) :: list(integer)
  #Sempre que for um número válido direciona para a função do_fibonacci
  #Na função do_fibonacci os elemento são adicionados no começo da lista, então no final usamos o reverse para que fique organizado corretamente.
  def run(number) when number > 0 do
    do_fibonacci(number, [1, 1])
    |> Enum.reverse()
  end
#A função recebe [1,1] no acumulador por padrão, então quando o usuário pede a segunda posição ou algo menor retornamos o acumulador [1,1]
#Já que são valores padrão da sequência
  def do_fibonacci(n, acc) when n <= 2, do: acc
#Para casos onde o elemento desejado está a frente do 2 pegamos os dois últimos elementos da lista (Na verdade os primeiros, mas a sequência está
#sendo feita por meio de prepending, então acabam sendo os últimos). Somamos eles e adicionamos no começo da lista.
#Esse processo é repetido até que n = 2, pois quando essa condição for satisfeita o acc será retornado. Nesse caso o n funciona como se fosse
#Um iterador
  def do_fibonacci(n, [second_last, last | _]=acc) do
    do_fibonacci(n - 1, [last + second_last | acc])
  end
end


defmodule FibonnacciTest do
  use ExUnit.Case, async: true

  test "deve retornar a sequência de fibonnacci com seus valores corretos" do
    assert Fibonnacci.run(2) == [1, 1]
    assert Fibonnacci.run(5) == [1, 1, 2, 3, 5]
    assert Fibonnacci.run(8) == [1, 1, 2, 3, 5, 8, 13, 21]
  end
end
