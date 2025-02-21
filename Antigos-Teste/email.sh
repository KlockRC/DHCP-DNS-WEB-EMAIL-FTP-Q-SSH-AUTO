#!/bin/bash
#
#
# automaçao DNS e APACHE e DHCP
# Ruan Cesar


#email
mailpost="/etc/postfix/main.cf"
mailcot="/etc/dovecot/dovecot.conf"
mailcot1="/etc/dovecot/conf.d/10-auth.conf"
mailcot2="/etc/dovecot/conf.d/10-mail.conf"
mailcot3="/etc/dovecot/conf.d/10-master.conf"
delMAIL="auth_mechanisms = plain"
delMAIL1="mail_location = mbox:~/mail:INBOX=/var/mail/%u"
pastaAP="/etc/apache2/sites-available"
tudoAP="/var/www"

shopt -s -o nounset


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

menuMAIL(){
    xML="continuar"
    while [ "$xML" == "continuar" ];
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
                    if [ command -v postfix &>/dev/null ]; then
                        echo " o programa ja esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " instalando o postfix "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install postfix -y
                    sleep 4
                    echo "instalado com sucesso"
                    
                     if [ comand -v dovecot &>/dev/null ]; then
                        echo " o programa ja esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " instalando o dovecot "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install dovecot-core dovecot-imapd -y
                    sleep 4
                    echo "instalado com sucesso"
                    ;;
                2)
                     if [ command -v postfix &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " desinstalando o postfix "
                        apt-get remove postfix
                        sleep 2
                    fi

                    if [ comand -v dovecot &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " desinstalando o dovecot "
                        apt-get remove dovecot-core dovecot-imapd
                        sleep 2
                    fi
                    ;;
                3)
                    echo "iniciando o postfix"
                    sleep 2
                    systemctl start postfix
                    echo "iniciando o dovecot"
                    sleep 2
                    systemctl start dovecot
                    ;;
                4)
                    echo "parando o postfix"
                    sleep 2
                    systemctl stop postfix
                    echo "parando o dovecot"
                    sleep 2
                    systemctl stop dovecot
                    ;;
                5)
                    echo "confiure ae"
                    sleep 2
                    confMAIL
                    ;;
                6)
                    echo "cloneeeeeeeeeeeee"
                    sleep 2
                    userEMAIL
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
                    xML="false"
                    ;;
                
                *)
                    echo "opçao invalida"
                    sleep 2
                    ;;
            esac
    done
}


confMAIL(){
    echo "home_mailbox = Maildir/" >> $mailpost
    echo "resolve_numeric_domain = yes" >> $mailpost
    echo "listen =*, ::" >> $mailcot
    echo "disable_plaintext_auth = no" >> $mailcot1
    sed -i "/$delMAIL/d" "$mailcot1"
    echo "auth_mechanisms = plain login" >> $mailcot1
    sed -i "\#$delMAIL1#d" "$mailcot2"
    echo "mail_location = maildir:~/Maildir" >> $mailcot2
    sed -i '105i\    unix_listener /var/spool/postfix/private/auth {\n        mode = 0666\n        user = postfix\n        group = postfix\n    }' $mailcot3
    mkdir /home/EMAIL
}

userEMAIL(){
    xUser="continuar"
    while [ "$xUser" == "continuar" ];
    do
    echo "quer criar o usuario (s/n)"
    read %URMAIL
        if [[ $URMAIL = s ]]; then
            echo "qual o nome o usuario"
            read UMAIL
            adduser  --gecos  --home /home/EMAIL/$UMAIL $UMAIL
        else
            xUser="batata"
        fi
    done
}

confWEBMAIL(){
    if [ command -v apache2 &>/dev/null ]; then
        echo " o programa base esta instalado add extençoes"
        apt-get install php7.3-curl php7.3 php7.3-xml libapache2-mod-php7.3 -y
        apt-get install git
        sleep 2
    else
        echo " instalando o apache "
        sleep 2
        #instalando o programa
        apt-get install apache2 php7.4-curl php7.4 php7.4-xml libapache2-mod-php7.4 -y
        apt-get install git
        echo "instalado com sucesso"
    fi

    
    echo "qual é o seu dominio de email? (com www, com .com/.local)"
    read rain
    echo "qual é o seu dominio de email? (sem www, sem.com/.local)"
    read rain1


    mkdir "$tudoAP/$rain1"

    touch "$pastaAP/$rain1.conf"

    echo "<VirtualHost *:80>" >> "$pastaAP/$rain1.conf"
    echo "      " >> "$pastaAP/$rain1.conf"
    echo "  ServerAdmin $rain1@$rain" >> "$pastaAP/$rain1.conf"
    echo "  ServerName $rain" >> "$pastaAP/$rain1.conf"
    echo "  DocumentRoot $tudoAP/$rain1" >> "$pastaAP/$rain1.conf"
    echo '  ErrorLog ${APACHE_LOG_DIR}/error.log' >> "$pastaAP/$rain1.conf"
    echo '  CustomLog ${APACHE_LOG_DIR}/access.log combined' >> "$pastaAP/$rain1.conf"
    echo "      " >> "$pastaAP/$rain1.conf"
    echo "</VirtualHost>" >> "$pastaAP/$rain1.conf"

    git clone https://github.com/RainLoop/rainloop-webmail.git $tudoAP/$rain1

    # ativar novo site e desativar o site padrão
    chmod 777 -R $tudoAP/$rain1
    a2ensite "$rain1.conf"
    a2dissite 000-default.conf
    systemctl restart apache2
    


    
}

menuCentral
