ExUnit.start()

defmodule FiltrarSomar do
  @doc """
  Filtra números maiores que N em uma lista e retorna a soma dos números filtrados.

  ## Dicas
  - Utilize recursão para filtrar e somar em uma única passagem.

  ## Exemplos

      iex> FiltrarSomar.run([1, 2, 3, 4, 5], 3)
      9

      iex> FiltrarSomar.run([1, 2, 3], 5)
      0
  """
  @spec run(list(integer), integer) :: integer
  def run([], n, acc), do: acc
  def run([h|t], n, acc) when(h<=n), do: run(t, n, acc)
  def run([h | t], n, acc\\0) when (h>n), do: run(t, n, acc + h)
end

defmodule FiltrarSomarTest do
  use ExUnit.Case, async: true

  test "filtra e soma números maiores que N" do
    assert FiltrarSomar.run([1, 2, 3, 4, 5], 3) == 9
  end

  test "retorna 0 se nenhum número for maior que N" do
    assert FiltrarSomar.run([1, 2, 3], 5) == 0
  end
end
