#!/bin/bash
#
#
# automaçao DNS e APACHE e DHCP
# Ruan Cesar


############################################################################################
#sistema
tudo1="/etc/network/interfaces"
list="/etc/apt/sources.list"
#apache
pastaAP="/etc/apache2/sites-available"
tudoAP="/var/www"
#dns
pastaDN="/etc/bind"
arq="named.conf.default-zones"
#DHCP
tudoDH="/etc/dhcp/dhcpd.conf"
tudoDH1="/etc/dhcp/dhcpd.conf.bkp"
PLDH="/etc/default/isc-dhcp-server"
#email
mailpost="/etc/postfix/main.cf"
mailcot="/etc/dovecot/dovecot.conf"
mailcot1="/etc/dovecot/conf.d/10-auth.conf"
mailcot2="/etc/dovecot/conf.d/10-mail.conf"
mailcot3="/etc/dovecot/conf.d/10-master.conf"
delMAIL="auth_mechanisms = plain"
#ftp
delFTP="UseIPv6 on"
tuFTP="/etc/proftpd/proftpd.conf"
#########################################################################################################


menuCentral(){
    while true;
    do
        echo "------------------------------------menu-------------------------------"
        echo "[ 1 - configuraçao do ip statico ]"
        echo ""
        echo "[ 2 - configurar souces.list ]"
        echo ""
        echo "[ 3 - DNS ]"
        echo ""
        echo "[ 4 - Apache ]"
        echo ""
        echo "[ 5 - DHCP ]"
        echo ""
        echo "[ 6 - Creditos ]"
        echo ""
        echo "[ 7 - email/webmail ]"
        echo ""
        echo "[ 8 - ftp ]"
        echo ""
        echo "[ 9 - Sair ]"
        echo ""
        
        echo "escolha as opções"
        read cent
        case "$cent" in
                    1)
                        echo "configuraçao de ip statico"
                        sleep 2
                        static
                        ;;
                    2)
                        echo "configuraçao de source.list"
                        sleep 2
                        souces
                        ;;
                    3)
                        echo "menu DNS"
                        sleep 2
                        menuDNS
                        ;;
                    4)
                        echo "menu Apache"
                        sleep 2
                        menuAPACHE
                        ;;
                    5)
                        echo "menu DHCP"
                        sleep 2
                        menuDHCP
                        ;;
                    6)
                        echo "creditos"
                        sleep 2
                        cred
                        ;;
                    7)
                        echo "email/webmail"
                        sleep 2
                        menuMAIL
                        ;;
                    8)
                        echo "ftp"
                        sleep 2
                        menuFTP
                        ;;
                    9)
                        echo "saindo"
                        sleep 2
                        exit 1
                        ;;
                    *)
                        echo "opçao invalida"
                        sleep 2
                        ;;
        esac
    done
}

menuFTP(){
    xFP="continuar"
    while [ "$xFP" == "continuar" ];
    do
            echo "------------------------------------EMAIL-------------------------------"
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
            echo "[7 - ver-usuarios-EMAIL]"
            echo ""
            echo "[8 - webmail]"
            echo ""
            echo "[9 - sair]"
            echo ""
            echo "escolha as opções"
            read opnMAIL
         case "$opnMAIL" in
                1)
                    if [ command -v proftpd &>/dev/null ]; then
                        echo " o programa ja esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " instalando o postfix "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install proftpd -y
                    apt-get install quota -y
                    sleep 4
                    echo "instalado com sucesso"
                    
                    ;;
                2)
                     if [ command -v proftpd &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " desinstalando o postfix "
                        apt-get remove proftpd
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
                    echo "confiure ae"
                    sleep 2
                    confFTP
                    ;;
                6)
                    echo "criar usuarios"
                    sleep 2
                    userFTP
                    ;;
                7)
                    echo "exibindo lista de usuarios EMAIL"
                    sleep 2
                    ls /home/EMAIL
                    sleep 2
                    ;;
                8)
                    echo "baixando webmail"
                    sleep 2
                    confWEBMAIL
                    ;;
                9)
                    echo "saindo......"
                    sleep 2
                    xFP="batata"
                    ;;
                
                *)
                    echo "opçao invalida"
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

userFTP(){
     echo "------------------------------------user-FTP-------------------------------"
            echo "[1 - crir usuario unico]"
            echo ""
            echo "[2 - importar de uma lista]"
            echo ""
            echo "escolha as opções"
            read opFTPUS
        case "$opFTPUS" in
            1)
                echo "bfioufy"
                ;;
            2)
                userlistFTP  
                ;;
        esac

}



userlistFTP(){

arquivo_usuarios="/root/batata/filiais.txt"
senha_padrao="Senai@127"

# Loop através do arquivo e formatar os nomes
while IFS=":" read -r nome senha; do
    # Remover espaços em branco no início e no final do nome
    nome_sem_espacos=$(echo "$nome" | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Substituir espaços por "_"
    nome_formatado=$(echo "$nome_sem_espacos" | tr ' ' '_')

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
            echo "Usuário $nome_formatado criado com sucesso no diretório $caminho_usuario."
        else
            echo "Falha ao criar o diretório $caminho_usuario."
        fi
    fi
        setquota -u $nome_formatado 0 $((5*1024)) 0 0 -a
done < "$arquivo_usuarios"


}

menuCentral