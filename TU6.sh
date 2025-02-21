#!/bin/bash
#
#
# automaçao DNS e WEB e DHCP e EMAIL e FTP e QUOTA
# Ruan Cesar e Mylena torquato
#
#
#

#Variaveis
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
delMAIL1="mail_location = mbox:~/mail:INBOX=/var/mail/%u"

#ftp
delFTP="UseIPv6 on"
tuFTP="/etc/proftpd/proftpd.conf"

#ssh
caSSH="/etc/ssh/sshd_config"
confSSH="PasswordAuthentication yes"
#########################################################################################################

shopt -s -o nounset



menuopncentralral(){
    while true;
    do
        echo "-/-/-/-/-/-/-/-//-//-/-/-/MENU PRINCIPAL-/-/-/-/-/-/-/-//-//-/-/-/"
        echo "[ 1 - IP  ]"
        echo ""
        echo "[ 2 - SOURCE LIST ]"
        echo ""
        echo "[ 3 - DNS ]"
        echo ""
        echo "[ 4 - APACHE ]"
        echo ""
        echo "[ 5 - DHCP ]"
        echo ""
        echo "[ 6 - FTP/QUOTA ]"
        echo ""
        echo "[ 7 - EMAIL/WEBMAIL ]"
        echo ""
        echo "[ 8 - SSH Install ]"
        echo ""
        echo "[ 9 - CRÉDITOS ]"
        echo ""
        echo "[ 10 - Sair ]"
        echo ""
        
        echo "Escolha a opção desejada: "
        read opncentral
        case "$opncentral" in
                    1)
                        echo "IP"
                        sleep 1
                        ipSTA
                        ;;
                    2)
                        echo "configuraçao de source.list"
                        sleep 1
                        souces
                        ;;
                    3)
                        echo "menu DNS"
                        sleep 1
                        menuDNS
                        ;;
                    4)
                        echo "menu Apache"
                        sleep 1
                        menuAPACHE
                        ;;
                    5)
                        echo "menu DHCP"
                        sleep 1
                        menuDHCP
                        ;;
                    6)
                        echo "menu ftp"
                        sleep 2
                        menuFTP
                        ;;
                    7)
                        echo "menu email/webmail"
                        sleep 1
                        menuMAIL
                        ;;
                    8)
                        echo "SSH instalaçao"
                        sleep 1
                        SSH
                        ;;
                    9)
                        echo "creditos"
                        sleep 1
                        cred
                        ;;
                    10)
                        echo "saindo"
                        sleep 1
                        exit 1
                        ;;
                    *)
                        echo "opção invalida"
                        sleep 1
                        ;;
        esac
    done
}


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
                    echo "Por favor configurar o QUOTA manualmente depois prosiga"
                    
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
                    
                     if [ command -v dovecot &>/dev/null ]; then
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

                    if [ command -v dovecot &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 1
                    else
                        echo " desinstalando o dovecot "
                        apt-get remove dovecot-core dovecot-imapd
                        sleep 1
                    fi
                    ;;
                3)
                    echo "iniciando o postfix"
                    sleep 1
                    systemctl start postfix
                    echo "iniciando o dovecot"
                    sleep 1
                    systemctl start dovecot
                    ;;
                4)
                    echo "parando o postfix"
                    sleep 1
                    systemctl stop postfix
                    echo "parando o dovecot"
                    sleep 1
                    systemctl stop dovecot
                    ;;
                5)
                    echo "configurando email"
                    sleep 1
                    confMAIL
                    ;;
                6)
                    echo "usuario para email"
                    sleep 1
                    userEMAIL
                    ;;
                7)
                    echo "exibindo lista de usuarios EMAIL"
                    sleep 1
                    ls /home/EMAIL
                    sleep 1
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



menuDHCP(){
    xDH="continuar"
    while [ "$xDH" == "continuar" ];
    do
       echo "------------------------------------DNS-------------------------------"
        echo "[ 1. Instalar ]"
        echo ""
        echo "[2. Desinstalar]"
        echo ""
        echo "[3. Iniciar ]"
        echo ""
        echo "[4. Parar]"
        echo ""
        echo "[5. Criar]"
        echo ""
        echo "[6. Informações]"
        echo ""
        echo "[7. Sair]"
        echo ""
        echo "Selecione a opção desejada: "
        read opnDHCP
        echo "------------------------------------------------------------------------"
            case "$opnDHCP" in
                1)
                    if [ command -v isc-dhcp-server &>/dev/null ]; then
                        echo "O programa já está instalado"
                        echo "Voltando para o menu"
                        sleep 2
                    else
                        echo " Instalando o DHCP "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install isc-dhcp-server -y
                    sleep 4
                    echo "Instalado com sucesso"
                    ;;
                2)
                    if [ ! command -v isc-dhcp-server &>/dev/null ]; then
                        echo "O programa não está instalado"
                        echo "Voltando para o menu..."
                        sleep 2
                    else
                        echo " Desinstalando o DHCP "
                        apt-get remove isc-dhcp-server
                        sleep 2
                    fi
                    ;;
                3)
                    echo "Iniciando DHCP"
                    sleep 2
                    systemctl start isc-dhcp-server
                    ;;
                4)
                    echo "Parando DHCP"
                    sleep 2
                    systemctl stop isc-dhcp-server
                    ;;
                5)
                    echo "Por favor, responda as perguntas abaixo: "
                    sleep 2
                    DHCP
                    ;;
                6)
                    echo "Informações do servidor:"
                    sleep 2
                    cat $tudoDH
                    ;;
                7)
                    echo "Saindo..."
                    sleep 2
                    xDH="batata"
                    ;;
                
                *)
                    echo "Escolha uma das opções corretas"
                    sleep 2
                    ;;
            esac
    done
}





menuAPACHE(){
    xAP="continuar"
    while [ "$xAP" == "continuar" ];
    do
            echo "------------------------------------APACHE-------------------------------"
            echo "[1 - Instalar]"
            echo ""
            echo "[2 - Desinstalar]"
            echo ""
            echo "[3 - Iniciar]"
            echo ""
            echo "[4 - Parar]"
            echo ""
            echo "[5 - Criar]"
            echo ""
            echo "[6 - git-clone para um site ja existente]"
            echo ""
            echo "[7 - modificar]"
            echo ""
            echo "[8 - excluir]"
            echo ""
            echo "[9 - ver-sites-hospedados]"
            echo ""
            echo "[10 - sair]"
            echo ""
            echo "escolha as opções"
            read opnAPACHE
         case "$opnAPACHE" in
                1)
                    if [ comand -v apache2 &>/dev/null ]; then
                        echo " o programa ja esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " instalando o apache "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install apache2 -y
                    sleep 4
                    echo "instalado com sucesso"
                    ;;
                2)
                    if [ ! comand -v apache2 &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                    else
                        echo " desinstalando o apache "
                        apt-get remove apache2
                        sleep 2
                    fi
                    ;;
                3)
                    echo "iniciando o apache"
                    sleep 2
                    systemctl start apache2
                    ;;
                4)
                    echo "parando o apache"
                    sleep 2
                    systemctl stop apache2
                    ;;
                5)
                    echo "pfv responda as perguntas abaixo"
                    sleep 2
                    criAPACHE
                
                    ;;
                6)
                    echo "cloneeeeeeeeeeeee"
                    sleep 2
                    gitclune
                    ;;
                7)
                    echo "modificando"
                    sleep 2
                    modAP
                    ;;
                8)
                    echo "apagando"
                    sleep 2
                    delAP
                    ;;
                9)
                    echo "listando"
                    sleep 2
                    ls $tudoAP
                    ;;
                10)
                    echo "saindo......"
                    sleep 2
                    xAP="false"
                    ;;
                
                *)
                    echo "opçao invalida"
                    sleep 2
                    ;;
            esac
    done
}




menuDNS(){
    xDN="continuar"
    while [ "$xDN" == "continuar" ];
    do
        echo "------------------------------------DNS-------------------------------"
        echo "[ 1. instalar ]"
        echo ""
        echo "[ 2. desinstalar ]"
        echo ""
        echo "[ 3. iniciar ]"
        echo ""
        echo "[ 4. parar ]"
        echo ""
        echo "[ 5. Criar ]" 
        echo ""
        echo "[ 6. editar ]"
        echo ""
        echo "[ 7. excluir ]"
        echo ""
        echo "[ 8. informações ]"
        echo ""
        echo "[ 9. sair ]"
        echo ""
        echo "selecione a opção"
        read opn
        echo "------------------------------------------------------------------------"
            case "$opn" in
                1)
                    if [ comand -v bind9 &>/dev/null ]; then
                        echo " o programa ja esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                        menu
                    else
                        echo " instalando o DNS "
                        sleep 2
                    fi

                    #instalando o programa
                    apt-get install bind9 -y
                    sleep 4
                    echo "instalado com sucesso"
                    ;;
                2)
                    if [ ! comand -v bind9 &>/dev/null ]; then
                        echo " o programa nao esta instalado "
                        echo "voltando para o menu"
                        sleep 2
                        menu
                    else
                        echo " desinstalando o DNS "
                        apt-get remove bind9
                        sleep 2
                    fi
                    ;;
                3)
                    echo "iniciando DNS"
                    sleep 2
                    systemctl start bind9
                    ;;
                4)
                    echo "parando DNS"
                    sleep 2
                    systemctl stop bind9
                    ;;
                5)
                    echo "pfv responda as perguntas abaixo"
                    sleep 2
                    CHDNS
                    ;;
                6)
                    echo "abrindo modificaçoes"
                    sleep 2
                    mod
                    ;;
                7)
                    echo "vamos remover"
                    sleep 2
                    del
                    ;;
                8)
                    echo " responda a pergunta abaixo"
                    sleep 2
                    mini
                    ;;
                9)
                    echo "saindo......"
                    sleep 2
                    xDN="batata"
                    ;;
                
                *)
                    echo "opçao invalida"
                    sleep 2
                    ;;
            esac
    done
}


mini(){
    xDNM="continuar"
    while [ "$xDNM" == "continuar" ];
    do
        echo "qual o dominio do seu site com o (.com/.local) e (sem www )"
        read sitecat
        echo "ok"
        sleep 2
        echo "-----------------------------------------------------------------------"
        echo "qual documento deseja ver?"
        echo ""
        echo "[ 1. named.conf.default-zones]"
        echo ""
        echo "[ 2. db.$sitecat ]"
        echo ""
        echo "[ 3. ver estatus do servidor DNS ]"
        echo ""
        echo "[ 4. sair ]"
        read opn3
        echo "----------------------------------------------------------------------------------"
        case "$opn3" in
            1)
                cat $pastaDN/$arq
                sleep 2
                ;;
            2)
                cat $pastaDN/db.$sitecat
                sleep 2
                ;;
            3)
                systemctl status bind9
                ;;
            4)
                voltando para o menu
                xDNM="batata"
                ;;

            *)
                echo "opção invalida"
                sleep 2
                ;;
        esac
    done
}


souces(){
        echo "------------------------------------souce-list-------------------------------"
        echo "[ 1. debian 10 ]"
        echo ""
        echo "[ 2. debian 11 ]"
        echo ""
        echo "[ 3. debian 12 ]"
        echo ""
        echo "[ 4. voltar ]"
        echo ""
        echo "echolha uma das opções"
        read opn2
        echo "------------------------------------------------------------------------------"
    case "$opn2" in
        1)
            echo "deb http://deb.debian.org/debian buster main contrib non-free" > $list
            echo "deb-src http://deb.debian.org/debian buster main contrib non-free" >> $list
            sleep 2
            ;;
        2)
            echo "deb http://deb.debian.org/debian bullseye main contrib non-free" > $list
            echo "deb-src http://deb.debian.org/debian bullseye main contrib non-free" >> $list
            sleep 2
            ;;
        3)
            echo "deb http://deb.debian.org/debian bookworm main non-free-firmware" > $list
            echo "deb-src http://deb.debian.org/debian bookworm main non-free-firmware" >> $list
            sleep 2
            ;;
        4)
            echo "voltando para o menu"
            sleep 2
            menu
            ;;
        *)
            echo "opção invalida"
            ;;
    esac
}








#perguntas necessarias
DNS(){

    echo "qual é o dominio do seu site? (sem www ) (com .com/.local)"
    read site
    echo "qual o dominio do seu site sem o (.com/.local) e (sem www )"
    read site1
    echo "qual é o ip do servidor web?"
    read web

    #Primeiro Arquivo

    echo zone \"$site\"\ { >> $pastaDN/$arq
    echo "      type master;" >> $pastaDN/$arq
    echo        file \"$pastaDN/db.$site\"\; >> $pastaDN/$arq
    echo "};" >> $pastaDN/$arq

    #Segundo arquivo 

    touch $pastaDN/db.$site
    echo "; BIND reverse data file for empty rfc1918 zone" >> $pastaDN/db.$site
    echo ";" >> $pastaDN/db.$site
    echo "; DO NOT EDIT THIS FILE - it is used for multiple zones." >> $pastaDN/db.$site
    echo "; Instead, copy it, edit named.conf, and use that copy." >> $pastaDN/db.$site
    echo ";" >> $pastaDN/db.$site
    echo '$TTL	86400' >> $pastaDN/db.$site
    echo "@	IN	SOA	ns1.$site. root.$site. (" >> $pastaDN/db.$site
    echo "			      1		; Serial" >> $pastaDN/db.$site
    echo "			 604800		; Refresh" >> $pastaDN/db.$site
    echo "			  86400		; Retry" >> $pastaDN/db.$site
    echo "			2419200		; Expire" >> $pastaDN/db.$site
    echo "			  86400 )	; Negative Cache TTL" >> $pastaDN/db.$site
    echo ";" >> $pastaDN/db.$site
    echo "@	    IN	NS  ns1.$site1.local." >> $pastaDN/db.$site
    echo "ns1   IN  A   $web" >> $pastaDN/db.$site
    echo "www   IN  A   $web" >> $pastaDN/db.$site
    systemctl restart bind9
}


#configuraçao de ip da maquina
ipSTA(){
     echo "------------------------------------IP-MENU-------------------------------"
            echo "[ 1 - ip fixo ]"
            echo ""
            echo "[ 2 - ip DHCP ]"
            echo ""
            echo "escolha as opções"
            read opIP
        case "$opIP" in
            1)
                echo "qual é o ip da maquina?"
                read ip
                echo "qual é a mask?"
                read mask
                echo "qual  o gateway?"
                read gateway

                echo "source /etc/network/interface.d/*" > $tudo1
                echo "auto lo" >>$tudo1
                echo "iface lo inet loopback" >>$tudo1
                echo "allow-hotplug enp0s3" >>$tudo1
                echo "iface enp0s3 inet static" >>$tudo1
                echo "address $ip" >>$tudo1
                echo "netmask $mask" >>$tudo1
                echo "gateway $gateway" >>$tudo1
                /etc/init.d/networking restart
                ;;
            2)
                echo "source /etc/network/interface.d/*" > $tudo1
                echo "auto lo" >>$tudo1
                echo "iface lo inet loopback" >>$tudo1
                echo "allow-hotplug enp0s3" >>$tudo1
                echo "iface enp0s3 inet dhcp" >>$tudo1
                /etc/init.d/networking restart
                ;;
            *)
                echo "operaçao Invalida"
                ;;
        esac


    

}


mod(){
    
        echo "------------------------------------Modificar-------------------------------"
        echo "1. dominio"
        echo ""
        echo "2. ip do servidor web"
        echo ""
        echo "3. tudo"
        echo ""
        echo "echolha uma das opções"
        read opn3
        echo "------------------------------------------------------------------------------"
    case "$opn3" in
    
        1)
            echo " qual é o dominio do seu site (antigo)? (sem www ) (com .com/.local)"
            read sitee
            echo "qual o dominio do seu site (antigo) sem o (.com/.local) e (sem www )"
            read sitee2
            echo "qual é o dominio do seu site? (NOVO) (sem www ) (com .com/.local)"
            read site
            echo "qual o dominio do seu site (NOVO) sem o (.com/.local) e (sem www )"
            read site1
    

            
            if grep -q "$sitee" $pastaDN/$arq; then
               
                sed -i "s/$sitee/$site/g" $pastaDN/$arq
                echo "Informação modificada com sucesso."
            else
                echo "error ao modificar o named.conf.default-zones "
            fi

            mv $pastaDN/db.$sitee $pastaDN/db.$site
        
            
            if grep -q "$sitee2" $pastaDN/db.$site; then
                
                sed -i "s/$sitee2/$site1/g" $pastaDN/db.$site
                
                echo "Informação modificada com sucesso (1/2)."
            else
                echo "error ao modificar o db.$site  "
            fi
         
            ;;
        2)
            echo "qual é o dominio do site com (.com/.local)"
            read site
            echo "qual é o ip do servidor web (antigo)?"
            read webb
            echo "qual é o ip do servidor web (novo)?"
            read webb1
            if grep -q "$webb" $pastaDN/db.$site; then
                sed -i "s/$webb/$webb1/g" $pastaDN/db.$site
                echo "Informação modificada com sucesso."
            else
                echo "error ao modificar o db.$site "
            fi
            ;;
        3)
            echo " qual é o dominio do seu site (antigo)? (sem www ) (com .com/.local)"
            read sitee
            echo "qual o dominio do seu site (antigo) sem o (.com/.local) e (sem www )"
            read sitee2
            echo "qual é o ip do servidor web (antigo)?"
            read webb
            echo "qual é o dominio do seu site? (NOVO) (sem www ) (com .com/.local)"
            read site
            echo "qual o dominio do seu site (NOVO) sem o (.com/.local) e (sem www )"
            read site1
            echo "qual é o ip do servidor web (novo)?"
            read webb1
    

            
            if grep -q "$sitee" $pastaDN/$arq; then
                
                sed -i "s/$sitee/$site/g" $pastaDN/$arq
                echo "Informação modificada com sucesso."
            else
                echo "error ao modificar o named.conf.default-zones "
            fi

            mv $pastaDN/db.$sitee $pastaDN/db.$site
        
            
            if grep -q "$sitee2" $pastaDN/db.$site; then
                
                sed -i "s/$sitee2/$site1/g" $pastaDN/db.$site
                
                echo "Informação modificada com sucesso (1/2)."
            else
                echo "error ao modificar o db.$site  "
            fi
           
            if grep -q "$webb" $pastaDN/db.$site; then
                sed -i "s/$webb/$webb1/g" $pastaDN/db.$site
                echo "Informação modificada com sucesso. (2/2)"
            else
                echo "error ao modificar o db.$site "
            fi
            ;;
        *)
            echo "opçao invalida"
            ;;
    
    esac


}

del(){
        echo "qual é o dominio do site PARA REMOÇÃO com (.com/.local) (sem www) "
        read sit


        sed -i "/zone \"$sit\" {/,/};/d" $pastaDN/$arq
        rm -f $pasta/db.$sit

}


criAPACHE(){

echo "iniciando configuraçao"

echo "qual é o seu dominio? (com www, com .com/.local)"
read site
echo "qual é o seu dominio? (sem www, sem.com/.local)"
read site1


    mkdir "$tudoAP/$site1"

    touch "$pastaAP/$site1.conf"

    echo "<VirtualHost *:80>" >> "$pastaAP/$site1.conf"
    echo "      " >> "$pastaAP/$site1.conf"
    echo "  ServerAdmin $site1@$site" >> "$pastaAP/$site1.conf"
    echo "  ServerName $site" >> "$pastaAP/$site1.conf"
    echo "  DocumentRoot $tudoAP/$site1" >> "$pastaAP/$site1.conf"
    echo '  ErrorLog ${APACHE_LOG_DIR}/error.log' >> "$pastaAP/$site1.conf"
    echo '  CustomLog ${APACHE_LOG_DIR}/access.log combined' >> "$pastaAP/$site1.conf"
    echo "      " >> "$pastaAP/$site1.conf"
    echo "</VirtualHost>" >> "$pastaAP/$site1.conf"

    # ativar novo site e desativar o site padrão
    a2ensite "$site1.conf"
    a2dissite 000-default.conf
    systemctl restart apache2

    echo "quer adcionar um git clone? (sim/nao)"
    read res

    if [[ $res == "sim" ]]; then
        echo "Instalando git"
        apt-get install git -y
        sleep 2
        echo "por favor coloque o link do git clone:"
        read git
        git clone "$git" "$tudoAP/$site1"
        echo "pronto"
    else
        echo "pronto"
    fi

}

gitclune(){
    echo "instalando o git"
    apt-get install git -y
    sleep 2
    
    echo " pfv adicione o http do git clone "
    read git
    echo "pfv qual o nome do site/pasta do site"
    read etis
    git clone $git $tudoAP/$etis
    echo "pronto"
}

modAP(){
    xDN="continuar"
    while [ "$xAPM" == "continuar" ];
    do
            echo "------------------------------------Modificar-------------------------------"
            echo "[ 1. nome do site ]"
            echo ""
            echo "[ 2. o conteudo (o site em si) ]"
            echo ""
            echo "[ 3. voltar ]"
            echo ""
            echo "echolha uma das opções"
            read modAPP
            case "$modAPP" in
        
            1)
                echo "qual o dominio do seu site (antigo) sem o (.com/.local) e (sem www )"
                read mods
                echo "qual o dominio do seu site (NOVO) sem o (.com/.local) e (sem www )"
                read mods2
        
                
                
                if grep -q "$mods" $pastaAP/$mods.conf; then
                
                    a2dissite $mods.conf
                    sed -i "s/$mods/$mods2/g" $pastaAP/$mods.conf
                    cp $pastaAP/$mods.conf $pastaAP/$mods2.conf
                    rm $pastaAP/$mods.conf
                    mv $tudoAP/$mods $tudoAP/$mods2
                    a2ensite $mods2.conf
                    echo "Informação modificada com sucesso."
                else
                    echo "error ao modificar o named.conf.default-zones "
                fi
                ;;
                
            2)
                echo "qual o dominio do seu site sem o (.com/.local) e (sem www )"
                read cont

                echo "apagando conteudo antigo"
                rm $tudoAP/$cont/*

                echo "instalando o git"
                apt-get install git -y
                sleep 2
                
                echo " pfv adicione o http do git clone "
                read git2
                git clone $git2 $tudoAP/$cont
                echo "pronto"
                ;;
            3)
                echo "voltando"
                xAPM="batata"
                sleep 2
                ;;
            *)
                echo "opçao invalida"
                ;;
        
        esac
    done
}

delAP(){
    echo "qual é o seu dominio? (sem www, sem.com/.local)"
    read situ

a2dissite $situ

sleep 2
rm -r $tudoAP/$situ
sleep 2

rm $pastaAP/$situ.conf
sleep 2

echo "pronto"
}





DHCP(){
    echo "Qual o nome do dominio?"
    read domain
    echo "Qual o IP do servidor DNS?"
    read dns
    echo "Qual o IP da rede?"
    read rede
    echo "Qual é a mask?"
    read mask
    echo "Qual é o tempo de expiração do IP ?(em segundos. EX: 86400)"
    read time2

# Configuracao de DHCP: dominio, tempo, rede, mascara
        
        cp $tudoDH $tudoDH1
        rm -f $tudoDH
        touch $tudoDH
        echo option domain-name \"$domain\"\; >> $tudoDH
        echo "option domain-name-servers $dns;" >> $tudoDH
        echo "default-lease-time $time2;" >> $tudoDH
        echo "authoritative;" >> $tudoDH
        echo "subnet $rede netmask $mask {" >> $tudoDH
        echo "          " >> $tudoDH
#Configuraçao range

    echo "Qual é o primeiro range?"
    read range
    echo "Qual é o segundo range?"
    read range1

#range no arquivo dhcp

    echo "  range $range $range1;" >> $tudoDH
    echo ""
    echo ""
    echo ""

#PERGUNTAS PARA CONFIGURAR MAIS OPÇÕES NO DHCP

xRANGE="continuar"
while [ "$xRANGE" == "continuar" ];
do
        echo "Quer adicionar outro range? (sim/nao)"
        read hange
    if [[ $hange == "sim" || $hange == "s" || $hange == "S" ]]; then
        echo "Qual o primeiro range?"
        read range
        echo "Qual é o segundo range?"
        read range1
        echo "  range $range $range1;" >> $tudoDH
    else
        echo "Ok"
        sleep 2
        xRANGE="batata"
    fi
done

    echo "Qual é o gateway?"
    read gatewayDHCP
    sleep 2

    
    echo "  option subnet-mask $mask;" >> $tudoDH
    echo "  option routers $gatewayDHCP;" >> $tudoDH
    echo "          " >> $tudoDH
    echo "}" >> $tudoDH

#COMANDO PARA AMARRACAO DE IP

    echo "Deseja amarrar ip? (sim/nao)"
    read hostDHCP
        if [[ $hostDHCP == "sim" || $hostDHCP == "s" || $hostDHCP == "S" ]]; then
            echo "Qual é o nome do dispositivo? (sem espaço)"
            read disp
            echo "Qual é o mac do dispositivo (separado por : )"
            read macDH
            echo "Qual o ip que deseja amarrar nesse dispositivos?"
            read ipfix
            sleep 2
            echo "Ok"
            echo ""
            echo "host $disp{" >> $tudoDH
            echo "  hardware ethernet $macDH;" >> $tudoDH
            echo "  fixed-address $ipfix;" >> $tudoDH
            echo "}" >> $tudoDH

                    #OUTRA AMARRACAO
                    xHOSTAM="continuar"
                    while [ "$xHOSTAM" == "continuar" ];
                    do
                        echo "Deseja amarrar OUTRO ip? (sim/nao)"
                        read hostMAR
                            if [[ $hostMAR == "sim" || $hostMAR == "s" || $hostMAR == "S" ]]; then
                                echo "Qual é o nome do dispositivo? (sem espaço)"
                                read disp
                                echo "Qual é o mac do dispositivo (separado por : )"
                                read macDH
                                echo "Qual o ip que deseja amarrar nesse dispositivos?"
                                read ipfix
                                sleep 2
                                echo "ok"
                #######################################################################################################
                                echo ""
                                echo "host $disp{" >> $tudoDH
                                echo "  hardware ethernet $macDH;" >> $tudoDH
                                echo "  fixed-address $ipfix;" >> $tudoDH
                                echo "}" >> $tudoDH
                #######################################################################################################
                            else
                                echo "ok"
                                xHOSTAM="batata"
                                sleep 2
                            fi
                    done

        else
            echo "ok"
            sleep 2
        fi

    
    echo "exibindo placas de rede instaladas"
    sleep 4
    ip add
    echo "pfv escolha a placa de saida do dhcp IPv4"
    read saida
    echo INTERFACESv4=\"$saida\" > $PLDH
    echo INTERFACESv6=\"\" >> $PLDH


}


cred(){
    echo "/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
    sleep 1
    echo "________________________________________Feito por Ruan Cesar e Mylena Torquato_______________________________________________"
    sleep 1
    echo "_____________________________________________________________________________________________________________________________"
    sleep 1
    echo "Automatizaçao dos Serviçõs:"
    sleep 1
    echo " DNS ________________________________________BIND9"
    sleep 1
    echo " WEB ________________________________________APACHE2"
    sleep 1
    echo " DHCP________________________________________ISC-DHCP-SERVER"
    sleep 1
    echo " EMAIL/WEBMAIL_______________________________POSTFIX - DOVECOT - RAINLOOP"
    sleep 1
    echo " FTP_________________________________________PROFTPD"
    sleep 1
    echo " Gerenciamento de Armazenamento______________QUOTA"
    sleep 1
    echo " SSH_________________________________________OPENSSH-SERVER"
    sleep 1
    echo " ______________________________________________________versão_________________________________________________________________"
    sleep 1
    echo " _______________________________________________________5.0___________________________________________________________________"
    sleep 1
    echo " "
    sleep 1
    echo " ____________________________________________________OBG, POR USAR :)_________________________________________________________"
    sleep 1
    echo " "
    sleep 1
    echo "///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
    sleep 1
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
    read URMAIL
        if [[ $URMAIL = s ]]; then
            echo "qual o nome o usuario"
            read UMAIL
            adduser  --gecos "" --home /home/EMAIL/$UMAIL $UMAIL
        else
            xUser="batata"
        fi
    done
}

confWEBMAIL(){
    if [ command -v apache2 &>/dev/null ]; then
        echo " o programa base esta instalado add extençoes"
        apt-get install php7.4-curl php7.4 php7.4-xml libapache2-mod-php7.4 -y
        apt-get install git -y
        sleep 2
    else
        echo " instalando o apache "
        sleep 2
        #instalando o programa
        apt-get install apache2 php7.4-curl php7.4 php7.4-xml libapache2-mod-php7.4 -y
        apt-get install git -y
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
            *)
                echo "opçao invalida"
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
            setquota -u $nome_formatado 0 $(($gig*1024)) 0 0 -a
            echo "Usuário $nome_formatado criado com sucesso no diretório $caminho_usuario."
        else
            echo "Falha ao criar o diretório $caminho_usuario."
        fi
    fi
done < "$arquivo_usuarios"


}

CHDNS(){
    echo "------------------------------------CRIAÇAO-DE-DOMINIO-------------------------------"
            echo "[1 - criar dominio unico ]"
            echo ""
            echo "[2 - importar de uma lista ]"
            echo ""
            echo "escolha as opções"
            read opDNSUS
        case "$opDNSUS" in
            1)
                echo "configurando usuario unico"
                DNS
                ;;
            2)
                echo "importando de uma lista"
                listDNS  
                ;;
            *)
                echo "opçao invalida"
                ;;
        esac

}

listDNS(){

    echo "insira o local da lista de usuarios"
    read arquivolistDNS
    echo "Ip do servidor WEB:* "
    read IPweb
    
    arquivo_usuarios="$arquivolistDNS"
        while IFS=":" read -r nome ; do
            # Remover espaços em branco no início e no final do nome
            nome_sem_espacos=$(echo "$nome" | sed 's/^[ \t]*//;s/[ \t]*$//')

            # Substituir espaços por "_"
            nome_formatado=$(echo "$nome_sem_espacos" | sed 's/ //g')

            # Remover acentos e caracteres especiais
            nome_limpo=$(echo "$nome_formatado" | iconv -f utf-8 -t ascii//TRANSLIT | tr -cd '[:alnum:]_')

            # Garanta que o nome_formatado não está vazio
            if [ -z "$nome_limpo" ]; then
                echo "Nome formatado está vazio. Ignorando."
                continue
            fi

            arquivoDB="log$nome_limpo.sp.br"
            arquivoDB1="log$nome_limpo"

                #Primeiro Arquivo

                echo zone \"$arquivoDB\"\ { >> $pastaDN/$arq
                echo "      type master;" >> $pastaDN/$arq
                echo        file \"$pastaDN/db.$arquivoDB\"\; >> $pastaDN/$arq
                echo "};" >> $pastaDN/$arq
                echo "" >> $pastaDN/$arq
                echo "#  Feito por Ruan Cesar e Mylena Torquato" >> $pastaDN/$arq
                echo "" >> $pastaDN/$arq

                #Segundo arquivo 

                touch $pastaDN/db.$arquivoDB


                echo "; BIND reverse data file for empty rfc1918 zone" >> $pastaDN/db.$arquivoDB
                echo ";" >> $pastaDN/db.$arquivoDB
                echo "; DO NOT EDIT THIS FILE - it is used for multiple zones." >> $pastaDN/db.$arquivoDB
                echo "; Instead, copy it, edit named.conf, and use that copy." >> $pastaDN/db.$arquivoDB
                echo ";" >> $pastaDN/db.$arquivoDB
                echo '$TTL	86400' >> $pastaDN/db.$arquivoDB
                echo "@	IN	SOA	ns1.$arquivoDB. root.$arquivoDB. (" >> $pastaDN/db.$arquivoDB
                echo "			      1		; Serial" >> $pastaDN/db.$arquivoDB
                echo "			 604800		; Refresh" >> $pastaDN/db.$arquivoDB
                echo "			  86400		; Retry" >> $pastaDN/db.$arquivoDB
                echo "			2419200		; Expire" >> $pastaDN/db.$arquivoDB
                echo "			  86400 )	; Negative Cache TTL" >> $pastaDN/db.$arquivoDB
                echo ";" >> $pastaDN/db.$arquivoDB
                echo "@	    IN	NS  ns1.$arquivoDB1.local." >> $pastaDN/db.$arquivoDB
                echo "ns1   IN  A   $IPweb" >> $pastaDN/db.$arquivoDB
                echo "www   IN  A   $IPweb" >> $pastaDN/db.$arquivoDB
                




        done < "$arquivo_usuarios"


        systemctl restart bind9
       
       
}

SSH(){
    if [ command -v openssh-server &>/dev/null ]; then
        echo " o programa  esta instalado"
    else
        echo " instalando o SSH "
        sleep 2
        #instalando o programa
        apt install openssh-server -y
        echo "instalado com sucesso"
    fi
echo "$confSSH" >> $caSSH

echo "escolha o nome do usuario"
read SSHUSR
adduser --gecos "" --home /home/$SSHUSR $SSHUSR
usermod -aG sudo $SSHUSR

echo "ssh pronto para uso"


}


if sudo -n true 2>/dev/null; then
    echo "O usuário tem privilégios sudo."
    sleep 1
    echo "deseja atulizar o sistema?? (s/n)"
    read aptupdate
        if [[ $aptupdate == "sim" || $aptupdate == "s" || $aptupdate == "S" ]]; then
            # atualizando o sistema
            echo "atualizando o sistema"
            sleep 2
            apt-get update -y && apt-get upgrade -y
            sleep 4
            menuopncentralral
        else
            menuopncentralral
        fi
else
    echo " pfv tenha permição sudo para executar esse script"
    echo "saindo..... "
    sleep 3
    exit 1
fi


