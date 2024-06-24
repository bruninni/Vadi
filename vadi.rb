require 'date'

# Função para validar email
def verifica_email(email)
  padrao = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  return !!(email =~ padrao)
end

# Função para validar telefone
def valida_telefone(numero)
  numero.gsub!(/\D/, '')

  if numero.length == 10 || numero.length == 11
    ddd = numero[0..1].to_i
    ddds_validos = [
      11, 12, 13, 14, 15, 16, 17, 18, 19,
      21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38,
      41, 42, 43, 44, 45, 46, 47, 48, 49,
      51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69,
      71, 73, 74, 75, 77, 79,
      81, 82, 83, 84, 85, 86, 87, 88, 89,
      91, 92, 93, 94, 95, 96, 97, 98, 99
    ]
    
    return dds_validos.include?(ddd)
  else
    return false
  end
end

# Função para validar senha
def verifica_senha(senha)
  return false if senha.length < 8
  return false unless senha =~ /[A-Z]/
  return false unless senha =~ /\d/
  return false unless senha =~ /[\W_]/
  return true
end

# Função para validar CPF
def valida_cpf(cpf)
  cpf.gsub!(/\D/, '')

  return false unless cpf.length == 11
  return false if cpf == cpf[0] * 11

  digito_verif1 = 0
  soma = 0
  9.times do |i|
    soma += cpf[i].to_i * (10 - i)
  end
  resto = soma % 11
  digito_verif1 = resto < 2 ? 0 : 11 - resto

  return false unless digito_verif1 == cpf[9].to_i

  soma = 0
  10.times do |i|
    soma += cpf[i].to_i * (11 - i)
  end
  resto = soma % 11
  digito_verif2 = resto < 2 ? 0 : 11 - resto

  return false unless digito_verif2 == cpf[10].to_i

  return true
end

# Função para validar data
def valida_data(data)
  formatos = ['%Y-%m-%d', '%d/%m/%Y']
  data_valida = false

  formatos.each do |formato|
    begin
      DateTime.strptime(data, formato)
      data_valida = true
      break
    rescue ArgumentError
      next
    end
  end

  return false unless data_valida

  begin
    dia, mes, ano = data.split(/[-\/]/).map(&:to_i)
    Date.new(ano, mes, dia)
    return true
  rescue ArgumentError
    return false
  end
end

# Função para validar nome de usuário
def valida_nome_usuario(usuario)
  return false unless usuario =~ /^[a-zA-Z0-9_]+$/
  return false unless (3..20).include?(usuario.length)
  return true
end

true
