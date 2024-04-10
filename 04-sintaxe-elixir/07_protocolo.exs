ExUnit.start()

defmodule Pessoa do
  defstruct name: nil, idade: 0
end

defmodule IA do
  defstruct name: nil, dev: nil, kill_humans: false
end

defprotocol Formatar do
  def formatar(entity)
end

defimpl Formatar, for: Pessoa do
  def formatar(%Pessoa{name: name, idade: idade}), do: "Olá #{name}! Chequei nas minhas informações e você tem #{idade} anos!"
end

defimpl Formatar, for: IA do
  def formatar(%IA{name: name, dev: dev, kill_humans: kill_humans}), do: "Olá #{name}! Você foi feita por #{dev} e sua resposta sobre matar humanos foi... #{kill_humans}"
end

defmodule ImplementacaoProtocolo do
  @doc """
  Implementa um protocolo para formatar structs diferentes.

  ## Dicas
  - Defina um protocolo `Formatar` com uma função `formatar/1`.
  - Implemente o protocolo para duas structs diferentes, retornando uma string formatada.

  ## Exemplos

      iex> ImplementacaoProtocolo.formatar(%MinhaStruct{name: "Elixir"})
      "MinhaStruct formatada: Elixir"
  """
  @spec formatar(map) :: String.t()
  def formatar(struct) do
    IO.inspect(Formatar.formatar(struct))
  end
end

defmodule ImplementacaoProtocoloTest do
  use ExUnit.Case, async: true

  test "formatação para pessoa" do
    assert ImplementacaoProtocolo.formatar(%Pessoa{name: "Jota", idade: 18}) ==
      "Olá Jota! Chequei nas minhas informações e você tem 18 anos!"
    end

  test "formatação para IA" do
    assert ImplementacaoProtocolo.formatar(%IA{name: "Rixile", dev: "Jota", kill_humans: true}) ==
      "Olá Rixile! Você foi feita por Jota e sua resposta sobre matar humanos foi... true"
  end
end
