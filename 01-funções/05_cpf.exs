ExUnit.start()

defmodule CPF do
  @doc """
  A validação de um CPF (Cadastro de Pessoas Físicas) brasileiro
  envolve a aplicação de regras matemáticas específicas para
  verificar se o número é válido. A lógica para validar um CPF
  pode ser dividida em várias etapas:

  1. Formato do CPF:
    - Verifique se o CPF contém 11 dígitos numéricos. Caso contrário, ele é inválido.
    - Remova qualquer formatação como pontos ou traços.

  2. Verificação de CPFs Inválidos Comuns:
    - CPFs com todos os dígitos iguais (como 111.111.111-11) são inválidos.

  3. Cálculo do Primeiro Dígito Verificador:
    - Multiplique os primeiros nove dígitos do CPF por pesos de 10 a 2.
    - Some todos os resultados das multiplicações.
    - Calcule o resto da divisão dessa soma por 11.
    - Se o resto for menor que 2, o primeiro dígito verificador é 0; caso
      contrário, subtraia o resto de 11 para obter o dígito.

  4. Cálculo do Segundo Dígito Verificador:
    - Repita o processo do terceiro passo, incluindo o primeiro dígito
      verificador e usando pesos de 11 a 2.

  5. Validação Final:
    - Compare os dígitos verificadores calculados com os dois últimos dígitos do CPF.
      Se ambos os pares de dígitos forem iguais, o CPF é válido.

  ## Dicas
  - [`String`](https://hexdocs.pm/elixir/String.html)
  - [`String.length/1`](https://hexdocs.pm/elixir/String.html#length/1)
  - [`String.replace/3`](https://hexdocs.pm/elixir/String.html#replace/4)
  """
  @spec run(String.t()) :: boolean
  def run(cpf) when is_binary(cpf) do
    if Regex.match?(~r/[0-9]{3}.[0-9]{3}.[0-9]{3}-[0-9]{2}/, cpf) do
       Regex.replace(~r/[.-]/, cpf, "")
       |> String.split("",trim: true)
       |> Enum.map(fn x -> String.to_integer(x) end)
       |> check_lasts
       |> IO.inspect
    else
      false
  end
end

def check_lasts(intcpf) do
    [l1, l2, l3 | null] =  Enum.chunk_every(intcpf, 9)
    check_firstlast(l1,l2)
end


defp check_firstlast(numbers, lasts) do
     summed = sum_mult(numbers)

     if rem(summed, 11) < 2 do
        0
     else
      rem(summed,11) - 11
      |> abs
     end
end

defp sum_mult([], mult, acc), do: acc

defp sum_mult([h | t], mult\\10, acc\\0) do
  IO.inspect(acc)
    sum_mult(t, mult - 1, acc + h*mult)
end

def check_equal(list) do
   if Enum.all?(list, fn x -> x == hd list end) do
    false
   else
    list
   end
end

end

defmodule CPFTest do
  use ExUnit.Case, async: true

  test "deve retornar true se for um CPF válido" do
    assert CPF.run("529.982.247-25") == true
  end

  test "deve retornar false se os dígitos verificadores nåo forem válidos" do
    refute CPF.run("529.982.247-24")
  end

  test "deve retornar false se os dígitos forem todos iguais" do
    refute CPF.run("111.111.111-11")
  end

  test "deve retornar false se houver caracteres nåo numéricos" do
    refute CPF.run("529a82247-25")
  end

  test "deve retornar false se o CPF tiver o tamanho incorreto" do
    refute CPF.run("529.982.24")
  end
end
