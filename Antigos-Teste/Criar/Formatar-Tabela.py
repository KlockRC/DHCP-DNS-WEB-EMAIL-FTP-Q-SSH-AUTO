import csv
from unidecode import unidecode

# Função para remover acentos
def remover_acentos(s):
    return unidecode(s)

# Nome do arquivo CSV de entrada e saída
nome_arquivo_entrada = "list.csv"
nome_arquivo_saida = "list_form.csv"

# Abrir o arquivo CSV de entrada
with open(nome_arquivo_entrada, mode='r', newline='', encoding='utf-8') as arquivo_csv_entrada:
    leitor_csv = csv.reader(arquivo_csv_entrada)
    linhas = list(leitor_csv)

# Remover acentos das colunas que contêm texto
linhas_formatadas = []
for linha in linhas:
    linha_formatada = [remover_acentos(str(valor)) if isinstance(valor, str) else valor for valor in linha]
    linhas_formatadas.append(linha_formatada)

# Abrir o arquivo CSV de saída para escrita
with open(nome_arquivo_saida, mode='w', newline='', encoding='utf-8') as arquivo_csv_saida:
    escritor_csv = csv.writer(arquivo_csv_saida)

    # Escrever as linhas formatadas no arquivo CSV de saída
    escritor_csv.writerows(linhas_formatadas)

print(f"Os dados foram formatados e salvos em '{nome_arquivo_saida}'.")
