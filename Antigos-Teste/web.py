import subprocess
import os
import sys
import shutil

# Verifica se o script está sendo executado como superusuário
def is_superuser():
    return os.geteuid() == 0

# Sai do script se não estiver sendo executado como superusuário
if not is_superuser():
    print("Este script requer privilégios de superusuário. Execute-o com sudo.")
    sys.exit(1)

# Instala o Apache se não estiver instalado
if not os.path.exists("/etc/apache2"):
    print("Apache não está instalado. Instalando...")
    subprocess.call(["apt-get", "update"])
    subprocess.call(["apt-get", "install", "apache2", "-y"])

# Caminho do diretório Pantera negra
project_path = "/var/www/html/Pantera negra"

# Lista de arquivos a serem copiados
files_to_copy = ['css', 'img', 'index.html', 'README.md']

# Sites
subprocess.call(["apt-get", "install", "git", "-y"])
subprocess.call(["git", "clone", "https://github.com/Vitor-ext/Exemplo-5-CSS-Pantera-Negra.git", "/var/www/html"])

# Copia os arquivos especificados para /var/www/html/
for file in files_to_copy:
    src_path = os.path.join(project_path, file)
    dest_path = '/var/www/html/'
    
    if os.path.exists(src_path):
        print(f"Copiando {file} para {dest_path}")
        if os.path.isdir(src_path):
            shutil.copytree(src_path, os.path.join(dest_path, file), dirs_exist_ok=True)
        else:
            shutil.copy(src_path, dest_path)


# Inicia o Apache
print("Iniciando o Apache...")
subprocess.call(["systemctl", "start", "apache2"])

# Habilita o Apache para iniciar na inicialização
print("Habilitando o Apache para iniciar na inicialização...")
subprocess.call(["systemctl", "enable", "apache2"])



# Exibe o status dont("Status do Apache:")
subprocess.call(["systemctl", "status", "apache2"])