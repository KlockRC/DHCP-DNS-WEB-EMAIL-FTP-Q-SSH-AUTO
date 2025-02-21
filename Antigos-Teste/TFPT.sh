#!/bin/bash
#
#
# automaçao FTP
# Ruan VCesar

#ftp
delFTP="UseIPv6 on"
tuFTP="/etc/proftpd/proftpd.conf"
#########################################################################################################


menuFTP(){
    xFP="continuar"
    while [ "$xFP" == "continuar" ];
    do
            echo "------------------------------------FTP-------------------------------"
            echo "[1 - Instalar]"
            echo ""
            echo "[2 - Desinstalar]"
            echo ""
            echo "[3 - Iniciar]"
            echo ""
            echo "[4 - Parar]"
            echo ""
            echo "[5 - Configurar]"
            echo ""
            echo "[6 - Criar-usuario]"
            echo ""
            echo "[7 - ver-usuarios-FTP]"
            echo ""
            echo "[8 - sair]"
            echo ""
            echo "escolha as opções"
            read opnFTP
         case "$opnFTP" in
                1)
                    if [ command -v proftpd &>/dev/null ]; then
                        echo " o programa ja esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " instalando o FTP/QUOTA "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install proftpd -y
                    apt-get install quota -y
                    sleep 4
                    echo "instalado com sucesso"
                    echo "Por favor configurar o QUOTA manualmente depois prossiga"
                    sleep 1
                    
                    ;;
                2)
                     if [ command -v proftpd &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " desinstalando o FTP/QUOTA "
                        apt-get remove proftpd
                        apt-get remove quota 
                        sleep 2
                    fi
                    ;;
                3)
                    echo "iniciando o FTP"
                    sleep 2
                    systemctl start proftpd
                    
                    ;;
                4)
                    echo "parando o FTP"
                    sleep 2
                    systemctl stop proftpd
                    ;;
                5)
                    echo "configurando FTP"
                    sleep 2
                    confFTP
                    ;;
                6)
                    echo "criar usuarios"
                    sleep 2
                    userFTPmenu
                    ;;
                7)
                    echo "exibindo lista de usuarios FTP"
                    sleep 1
                    ls /var/www
                    sleep 1
                    ;;
                8)
                    echo "saindo......"
                    sleep 2
                    xFP="batata"
                    ;;
                
                *)
                    echo "opção invalida"
                    sleep 2
                    ;;
            esac
    done
}

confFTP(){
    sed -i "\#$delFTP#d" "$tuFTP"
    sed -i '11i\ UseIPv6 off  ' $tuFTP
    sed -i '39i\ DefaultRoot            ~ ' $tuFTP
    sed -i '44i\ RequireValidShell off ' $tuFTP
    echo "<IfModule mod_quotatab.c>" >> $tuFTP
    echo "QuotaEngine on" >> $tuFTP
    echo "QuotaDisplayUnits Gb" >> $tuFTP
    echo "QuotaShowQuotas on" >> $tuFTP
    echo "</IfModule>" >> $tuFTP
}

userFTPmenu(){
     echo "------------------------------------USER-FTP-------------------------------"
            echo "[1 - crir usuario unico ]"
            echo ""
            echo "[2 - importar de uma lista ]"
            echo ""
            echo "escolha as opções"
            read opFTPUS
        case "$opFTPUS" in
            1)
                echo "user-FTP"
                userFTP
                ;;
            2)
                userlistFTP  
                ;;
        esac

}

userFTP(){

    echo "coloque o nome de usuario:"
    read nome_formatado

    echo "quantos gigas vai ter o usuario?"
    read gig

    echo "qual a senha do usuario?"
    read senha_padrao

     # Caminho do diretório para o usuário
    caminho_usuario="/var/www/$nome_formatado"

    # Verifique se o usuário já existe
    if id "$nome_formatado" &>/dev/null; then
        echo "Usuário $nome_formatado já existe. Ignorando."
    else
        # Crie o diretório para o usuário
        mkdir -p "$caminho_usuario"
        
        # Verifique se o diretório foi criado com sucesso
        if [ -d "$caminho_usuario" ]; then
            echo "Diretório $caminho_usuario criado."

            # Crie o usuário com a senha
            useradd -m -p "$(openssl passwd -1 "$senha_padrao")" -d "$caminho_usuario" -c "$nome_formatado" "$nome_formatado" -s /bin/false
            setquota -u $nome_formatado 0 $(($gig*1024)) 0 0 -a
            echo "Usuário $nome_formatado criado com sucesso no diretório $caminho_usuario."
        else
            echo "Falha ao criar o diretório $caminho_usuario."
        fi
    fi
}

userlistFTP(){

echo "insira o local da lista de usuarios"
read arquivoFTP
echo "quantos gigas vai ter cada usuario?"
read gig
echo "qual a senha padrão dos usuarios?"
read senha_padrao



arquivo_usuarios="$arquivoFTP"

# Loop através do arquivo e formatar os nomes
while IFS=":" read -r nome senha; do
    # Remover espaços em branco no início e no final do nome
    nome_sem_espacos=$(echo "$nome" | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Substituir espaços por "_"
    nome_formatado=$(echo "$nome_sem_espacos" | tr -d ' ')

    # Remover acentos e caracteres especiais
    nome_formatado=$(echo "$nome_formatado" | iconv -f utf-8 -t ascii//TRANSLIT | tr -cd '[:alnum:]_')

    # Garanta que o nome_formatado não está vazio
    if [ -z "$nome_formatado" ]; then
        echo "Nome formatado está vazio. Ignorando."
        continue
    fi

    # Caminho do diretório para o usuário
    caminho_usuario="/var/www/$nome_formatado"

    # Verifique se o usuário já existe
    if id "$nome_formatado" &>/dev/null; then
        echo "Usuário $nome_formatado já existe. Ignorando."
    else
        # Crie o diretório para o usuário
        mkdir -p "$caminho_usuario"
        
        # Verifique se o diretório foi criado com sucesso
        if [ -d "$caminho_usuario" ]; then
            echo "Diretório $caminho_usuario criado."

            # Crie o usuário com a senha
            useradd -m -p "$(openssl passwd -1 "$senha_padrao")" -d "$caminho_usuario" -c "$nome_formatado" "$nome_formatado" -s /bin/false
            setquota -u $nome_formatado 0 $(($gig*1024)) 0 0 -a
            echo "Usuário $nome_formatado criado com sucesso no diretório $caminho_usuario."
        else
            echo "Falha ao criar o diretório $caminho_usuario."
        fi
    fi
done < "$arquivo_usuarios"

menuFTP


