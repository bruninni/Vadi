from re import *
from datetime import datetime

class Validador:
    
    @staticmethod
    def verifica_email(email):
        padrao = r'^[\w\.-]+@[a-zA-Z]+\.[a-zA-Z]{2,}$'
        if match(padrao, email):
            return True
        else:
            return False
    
    @staticmethod
    def valida_telefone(numero):
        numero = sub(r'\D', '', numero)

        if len(numero) == 10 or len(numero) == 11:
            ddd = int(numero[0:2])
            ddds_validos = [
                11, 12, 13, 14, 15, 16, 17, 18, 19,
                21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38,
                41, 42, 43, 44, 45, 46, 47, 48, 49,
                51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69,
                71, 73, 74, 75, 77, 79,
                81, 82, 83, 84, 85, 86, 87, 88, 89,
                91, 92, 93, 94, 95, 96, 97, 98, 99
            ]
        
            if ddd in ddds_validos:
                return True
            else:
                return False
        else:
            return False

    @staticmethod
    def verifica_senha(senha):
        if len(senha) < 8:
            return False
        if not search(r'[A-Z]', senha):
            return False
        if not search(r'\d', senha):
            return False
        if not search(r'[\W_]', senha):
            return False 
        return True

    @staticmethod
    def valida_cpf(cpf):
        # Remove caracteres não numéricos do CPF
        cpf = ''.join(filter(str.isdigit, cpf))

        # Verifica se o CPF tem 11 dígitos
        if len(cpf) != 11:
            return False

        # Verifica se todos os dígitos são iguais (caso contrário, não são válidos)
        if cpf == cpf[0] * 11:
            return False

        # Calcula o primeiro dígito verificador
        soma = 0
        for i in range(9):
            soma += int(cpf[i]) * (10 - i)
        resto = soma % 11
        if resto < 2:
            digito_verif1 = 0
        else:
            digito_verif1 = 11 - resto

        # Verifica o primeiro dígito verificador
        if digito_verif1 != int(cpf[9]):
            return False

        # Calcula o segundo dígito verificador
        soma = 0
        for i in range(10):
            soma += int(cpf[i]) * (11 - i)
        resto = soma % 11
        if resto < 2:
            digito_verif2 = 0
        else:
            digito_verif2 = 11 - resto

        # Verifica o segundo dígito verificador
        if digito_verif2 != int(cpf[10]):
            return False

        # Se passou por todas as verificações, o CPF é válido
        return True

    @staticmethod
    def valida_data(data):
        formatos = ['%Y-%m-%d', '%d/%m/%Y']
        data_valida = False
        
        for formato in formatos:
            try:
                # Tenta converter a string de data para objeto datetime
                datetime.strptime(data, formato)
                data_valida = True
                break
            except ValueError:
                continue
        
        if not data_valida:
            return False
        
        # Verifica se a data é válida (por exemplo, não permitir 30 de fevereiro)
        try:
            dia, mes, ano = map(int, data.split('-' if '-' in data else '/'))
            datetime(ano, mes, dia)
            return True
        except ValueError:
            return False

    @staticmethod
    def valida_nome_usuario(usuario):
        # Verifica se o nome de usuário contém apenas letras, números e sublinhados
        if not match(r'^[a-zA-Z0-9_]+$', usuario):
            return False
        
        # Verifica se o comprimento do nome de usuário está entre 3 e 20 caracteres
        if len(usuario) < 3 or len(usuario) > 20:
            return False
        
        
        return True



