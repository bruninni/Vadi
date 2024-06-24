defmodule Validador do
  import Regex, only: [match?: 2]

  # Função para validar email
  def verifica_email(email) do
    padrao = ~r/^[\w\.-]+@[a-zA-Z]+\.[a-zA-Z]{2,}$/
    match?(padrao, email)
  end

  # Função para validar telefone
  def valida_telefone(numero) do
    numero = String.replace(numero, ~r/\D/, "")

    cond do
      String.length(numero) in [10, 11] ->
        ddd = String.slice(numero, 0, 2) |> String.to_integer()
        ddds_validos = [
          11, 12, 13, 14, 15, 16, 17, 18, 19,
          21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38,
          41, 42, 43, 44, 45, 46, 47, 48, 49,
          51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69,
          71, 73, 74, 75, 77, 79,
          81, 82, 83, 84, 85, 86, 87, 88, 89,
          91, 92, 93, 94, 95, 96, 97, 98, 99
        ]
        ddd in ddds_validos

      true ->
        false
    end
  end

  # Função para validar senha
  def verifica_senha(senha) do
    has_upper = String.match?(senha, ~r/[A-Z]/)
    has_digit = String.match?(senha, ~r/\d/)
    has_special = String.match?(senha, ~r/[\W_]/)
    String.length(senha) >= 8 && has_upper && has_digit && has_special
  end

  # Função para validar CPF
  def valida_cpf(cpf) do
    cpf = String.replace(cpf, ~r/\D/, "")

    cond do
      String.length(cpf) != 11 ->
        false

      String.match?(cpf, ~r/^(\d)\1{10}$/) ->
        false

      true ->
        digito_verif1 = calcula_digito_verificador(String.slice(cpf, 0, 9))
        digito_verif2 = calcula_digito_verificador(cpf)
        digito_verif1 == String.to_integer(String.slice(cpf, 9)) &&
          digito_verif2 == String.to_integer(String.slice(cpf, 10))
    end
  end

  defp calcula_digito_verificador(digits) do
    soma = Enum.zip(digits, 10..1)
            |> Enum.map(fn {d, weight} -> String.to_integer(d) * weight end)
            |> Enum.sum()
    resto = soma |> rem(11)
    if resto < 2, do: 0, else: 11 - resto
  end

  # Função para validar data
  def valida_data(data) do
    formatos = ["%Y-%m-%d", "%d/%m/%Y"]

    cond do
      Enum.any?(formatos, &Date.valid?(data, &1)) ->
        true

      true ->
        false
    end
  end

  # Função para validar nome de usuário
  def valida_nome_usuario(usuario) do
    cond do
      String.match?(usuario, ~r/^[a-zA-Z0-9_]+$/) && String.length(usuario) in 3..20 ->
        true

      true ->
        false
    end
  end
end

# Exemplos de utilização das funções (comentados)
# Os exemplos foram removidos para manter apenas as funções de validação.

# Retornar verdadeiro para utilizar essas funções
