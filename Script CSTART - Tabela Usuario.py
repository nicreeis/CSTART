# Challenge - Grupo Daily Data

import csv

# Declarando uma classe de exceção para números inválidos
class NumeroInvalidoError(Exception):
  pass

# Definindo a estrutura da tabela
tabela = {
    "id_usuario": [],
    "nm_usuario": [],
    "ds_email": [],
    "cd_cidade": [],
    "dt_nascimento": [],
    "ds_genero": [],
    "nr_ddd": [],
    "nr_telefone": []
}

# Preenchendo a tabela com 5 registros
for i in range(5):
    id_valido = False
    while not id_valido:
        try:
            id = int(input("Digite o ID do usuário de 5 dígitos numéricos: "))
            if len(str(id)) != 5 :
                raise NumeroInvalidoError("ID do usuário inválido. Deve ter 5 dígitos.")
            tabela["id_usuario"].append(id)
            id_valido = True
        except NumeroInvalidoError as nie:
            print(f"Erro de número: {nie}")
        except Exception as e:
            print(f"Erro desconhecido: {e}")

    tabela["nm_usuario"].append(input("Digite o nome do usuário: "))
    tabela["ds_email"].append(input("Digite o email do usuário: "))
    tabela["cd_cidade"].append(input("Digite a cidade do usuário: "))
    tabela["dt_nascimento"].append(input("Digite a data de nascimento do usuário (dd/mm/yyyy): "))

    genero_valido = False
    while not genero_valido:
        try:
            genero = input("Digite o gênero do usuário (M/F/NB): ").upper()
            if genero not in ['M', 'F', 'NB']:
                raise ValueError("Gênero inválido. Deve ser 'M' ou 'F' ou 'NB'.")
            tabela["ds_genero"].append(genero)
            genero_valido = True
        except ValueError as ve:
            print(f"Erro de valor: {ve}")
        except Exception as e:
            print(f"Erro desconhecido: {e}")

    ddd_valido = False
    while not ddd_valido:
        try:
            ddd = int(input("Digite o DDD do usuário: "))
            if len(str(ddd)) != 2 :
                raise NumeroInvalidoError("DDD inválido. Deve ter 2 dígitos.")
            tabela["nr_ddd"].append(ddd)
            ddd_valido = True
        except NumeroInvalidoError as nie:
            print(f"Erro de número: {nie}")
        except Exception as e:
            print(f"Erro desconhecido: {e}")

    telefone_valido = False
    while not telefone_valido:
        try:
            telefone = int(input("Digite o telefone do usuário: "))
            if len(str(telefone)) not in [8, 9]:
                raise NumeroInvalidoError("Número de telefone inválido. Deve ter entre 8 e 9 dígitos.")
            tabela["nr_telefone"].append(telefone)
            telefone_valido = True
        except NumeroInvalidoError as nie:
            print(f"Erro de número: {nie}")
        except Exception as e:
            print(f"Erro desconhecido: {e}")
          
    print("-"*60)

# Gravando os dados em um arquivo CSV
try:
    with open('t_cstart_usuario.csv', 'w', newline='') as arqcstart:
        writer = csv.writer(arqcstart)
        writer.writerow(tabela.keys())
        for i in range(len(tabela["id_usuario"])):
            writer.writerow([tabela[key][i] for key in tabela])
except Exception as e:
    print(f"Erro ao gravar no arquivo: {e}")
