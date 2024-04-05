ExUnit.start()

defmodule VerificacaoParenteses do
  @doc """
  Verifica se os parênteses em uma string estão corretamente balanceados.
  A função deve retornar `true` se a string estiver corretamente balanceada
  e `false` caso contrário. Considere apenas os caracteres `(` e `)`.

  ## Dicas
  - Utilize uma função auxiliar recursiva que mantenha uma contagem de parênteses abertos.
  - Lembre-se de que, em qualquer ponto da string, o número de parênteses fechando não pode ser maior que o número de parênteses abrindo.

  ## Exemplos

      iex> VerificacaoParenteses.run("()")
      true

      iex> VerificacaoParenteses.run("((()))")
      true

      iex> VerificacaoParenteses.run("(()")
      false
  """
  @spec run(String.t(), bitstring, integer, integer) :: boolean



  def run(s, last, left, right, 2), do: false
  def run("", last, left, right, switched) when left == right, do: true
  def run("", last, left, right, switched) when left != right, do: false

  def run(s, last\\40, left\\0, right\\0, switched\\0) do
    [h | t] = to_charlist(s)
    cond do
      h == 40 and h == last -> run(to_string(t), h, left + 1, right, 0)
      h == 40 and h != last -> run(to_string(t), h, left + 1, right, switched + 1)
      h == 41 and h == last -> run(to_string(t), h, left, right + 1, 0)
      h == 41 and h != last -> run(to_string(t), h, left, right + 1, switched + 1)
      true -> :error
    end
  end

end

defmodule VerificacaoParentesesTest do
  use ExUnit.Case, async: true

  test "deve retornar true para uma string vazia" do
    assert VerificacaoParenteses.run("") == true
  end

  test "deve retornar true para strings com parênteses corretamente balanceados" do
    assert VerificacaoParenteses.run("()") == true
    assert VerificacaoParenteses.run("((()))") == true
  end

  test "deve retornar false para strings com parênteses não balanceados" do
    assert VerificacaoParenteses.run(")(") == false
    assert VerificacaoParenteses.run("((())") == false
  end
end
