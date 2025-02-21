#!/bin/bash
#
#
# automaçao DNS e APACHE e DHCP
# Ruan Cesar e Mylena torquato

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

#ftp
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
        echo "[ 6 - CRÉDITOS ]"
        echo ""
        echo "[ 7 - EMAIL/WEBMAIL ]"
        echo ""
        echo "[ 8 - FTP ]"
        echo ""
        echo "[ 9 - Sair ]"
        echo ""
        
        echo "Escolha a opção desejada: "
        read opncentral
        case "$opncentral" in
                    1)
                        echo "IP"
                        sleep 2
                        ip
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
            echo "[8 - sair]"
            echo ""
            echo "escolha as opções"
            read opnMAIL
         case "$opnMAIL" in
                1)
                    if [ comand -v postfix &>/dev/null ]; then
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
                     if [ comand -v postfix &>/dev/null ]; then
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
                    echo "pfv responda as perguntas abaixo"
                    sleep 2
                    confMAIL
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
                    DNS
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
        echo "qual o dominio do seu site sem o (.com/.local) e (sem www )"
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
ip(){

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
    if [[ $hange == "sim" || "s" || "S" ]]; then
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
        if [[ $hostDHCP == "sim" || "s" || "S" ]]; then
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

        else
            echo "ok"
            sleep 2
        fi

    #OUTRA AMARRACAO
    xHOSTAM="continuar"
    while [ "$xHOSTAM" == "continuar" ];
    do
        echo "Deseja amarrar OUTRO ip? (sim/nao)"
        read hostMAR
            if [[ $hostMAR == "sim" || "s" || "S" ]]; then
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
    echo " EMAIL/WEBMAIL_______________________________POSTFIX , DOVECOT e RAINLOOP"
    sleep 1
    echo " FTP_________________________________________PROFTPD"
    sleep 1
    echo " Gerenciamento de Armazenamento______________Quota"
    sleep 1
    echo " ______________________________________________________versão_________________________________________________________________"
    sleep 1
    echo " _______________________________________________________2.0___________________________________________________________________"
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

}

ftp(){
}

if sudo -n true 2>/dev/null; then
    echo "O usuário tem privilégios sudo."
    sleep 2
    # atualizando o sistema
    echo "atualizando o sistema"
    sleep 2
    apt-get update -y && apt-get upgrade -y
    sleep 4
    menuopncentralral
else
    echo " pfv tenha permiçao sudo para executar esse script"
    echo "saindo..... "
    sleep 3
    exit 1
fi


