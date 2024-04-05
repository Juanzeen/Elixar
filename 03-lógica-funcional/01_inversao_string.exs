ExUnit.start()

defmodule InversaoString do
  @doc """
  Inverte uma string fornecida utilizando recursão.

  ## Dicas
  - Lembre-se de que uma string pode ser tratada como uma lista de caracteres.
  - Considere o caso base onde a string é vazia.

  ## Exemplos

      iex> InversaoString.run("elixir")
      "rixile"

      iex> InversaoString.run("")
      ""
  """
  @spec run(String.t()) :: String.t()
  def run("", acc), do: acc
  def run(s, acc\\"") do
    #converte a string em uma charlist
      [h | t] = to_charlist(s)
    #charlists podem receber o método to_string, mas ele não pode ser aplicado a chars individuais
      to_string(t)
    #então, para converter o inteiro que representa o head em um char usamos a notação <<h::utf8>>
    #essa é a notação de bitstrings, que trata-se de uma sequência contígua de bits na memória
    #basicamente temos o seguinte <<int_value::size_of_the_value_in_bits>>, assim nós passamos o "tamanho" UTF8 e convertemos para um char
      |>run(<<h::utf8>> <> acc)

  end
end

defmodule InversaoStringTest do
  use ExUnit.Case, async: true

  test "inverte uma string não vazia" do
    assert InversaoString.run("elixir") == "rixile"
  end

  test "retorna uma string vazia quando a entrada também for uma string vazia" do
    assert InversaoString.run("") == ""
  end
end
