ExUnit.start()

defmodule MeuModuloQueChecaSeDoisNumerosSaoInteiros do

def run(n1,n2) when n1 == nil or n2 == nil, do: :error
def run(n1, n2) when is_integer(n1) == false or is_integer(n2)== false, do: :error
def run(n1,n2) when is_integer(n1) and is_integer(n2), do: :ok

end

defmodule UsoAlias do
  @doc """
  Demonstra o uso de `alias` para simplificar a chamada de uma função de um módulo longo.

  ## Dicas
  - Defina um módulo com um nome longo e use `alias` para encurtá-lo.

  ## Exemplos

      iex> UsoAlias.run()
      :ok
  """
  @spec run() :: atom
  def run() do

    alias MeuModuloQueChecaSeDoisNumerosSaoInteiros, as: Check
    Check.run(5,1)
  end
end

defmodule UsoAliasTest do
  use ExUnit.Case, async: true

  test "demonstra o uso de alias" do
    assert UsoAlias.run() == :ok
  end
end
