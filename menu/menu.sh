#!/bin/bash

BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="raw.githubusercontent.com/arzvpn/proarzv2/main"
export Server1_URL="raw.githubusercontent.com/arzvpn/lim2/main"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther=".geovpn"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Validate Result ( 1 )
touch /etc/${Auther}/license.key
export Your_License_Key="$( cat /etc/${Auther}/license.key | awk '{print $1}' )"
export Validated_Your_License_Key_With_Server="$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 1 )"
if [[ "$Validated_Your_License_Key_With_Server" == "$Your_License_Key" ]]; then
    validated='true'
else
    echo -e "${EROR} License Key Not Valid"
    exit 1
fi

# // Checking VPS Status > Got Banned / No
if [[ $IP == "$( curl -s https://${Server_URL}/blacklist.txt | cut -d ' ' -f 1 | grep -w $IP | head -n1 )" ]]; then
    echo -e "${EROR} 403 Forbidden ( Your VPS Has Been Banned )"
    exit  1
fi

# // Checking VPS Status > Got Banned / No
if [[ $Your_License_Key == "$( curl -s https://${Server_URL} | cut -d ' ' -f 1 | grep -w $Your_License_Key | head -n1)" ]]; then
    echo -e "${EROR} 403 Forbidden ( Your License Has Been Limited )"
    exit  1
fi

# // Checking VPS Status > Got Banned / No
if [[ 'Standart' == "$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 6 )" ]]; then 
    License_Mode='Standart'
elif [[ Pro == "$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 6 )" ]]; then 
    License_Mode='Pro'
else
    echo -e "${EROR} Please Using Genuine License !"
    exit 1
fi

# // Checking Script Expired
exp=$( curl -s https://${Server1_URL}/limit.txt | grep -w $IP | cut -d ' ' -f 3 )
now=`date -d "0 days" +"%Y-%m-%d"`
expired_date=$(date -d "$exp" +%s)
now_date=$(date -d "$now" +%s)
sisa_hari=$(( ($expired_date - $now_date) / 86400 ))
if [[ $sisa_hari -lt 0 ]]; then
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
    echo -e "${EROR} Your License Key Expired ( $sisa_hari Days )"
    exit 1
else
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
fi

# // Clear
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel5 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${green}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
function addhost(){
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
rm -fr /etc/xray/domain
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo $host > /etc/xray/domain
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Dont forget to renew gen-ssl"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function genssl(){
clear
systemctl stop nginx
systemctl stop xray
domain=$(cat /var/lib/scrz-prem/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew gen-ssl... " 
sleep 2
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew gen-ssl done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /etc/xray/domain
systemctl start nginx
systemctl start xray
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
export sem=$( curl -s https://raw.githubusercontent.com/arzvpn/Arzv2/main/version)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
export Server_URL="raw.githubusercontent.com/arzvpn/lim2/main"
License_Key=$(cat /etc/${Auther}/license.key)
export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
clear
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │                  ${BIWhite}${UWhite}Server Informations${NC}"
echo -e "${BICyan} │"
echo -e " ${BICyan}│  ${BICyan}Use Core        :  ${BIPurple}Arzvpn${NC}"
echo -e " ${BICyan}│  ${BICyan}Current Domain  :  ${BIPurple}$(cat /etc/xray/domain)${NC}"
echo -e " ${BICyan}│  ${BICyan}IP-VPS          :  ${BIYellow}$IPVPS${NC}"
echo -e " ${BICyan}│  ${BICyan}ISP-VPS         :  ${BIYellow}$ISPVPS${NC}"
echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
echo -e "     ${BICyan} SSH ${NC}: $ressh"" ${BICyan} NGINX ${NC}: $resngx"" ${BICyan}  XRAY ${NC}: $resv2r"" ${BICyan} TROJAN ${NC}: $resv2r"
echo -e "     ${BICyan}          DROPBEAR ${NC}: $resdbr" "${BICyan} SSH-WS ${NC}: $ressshws"
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "     ${BICyan}[${BIWhite}1${BICyan}] SSH ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}2${BICyan}] VMESS ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}3${BICyan}] VLESS ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}4${BICyan}] TROJAN ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}5${BICyan}] SHADOWSOCKS ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}6${BICyan}] TENDANG ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}7${BICyan}] AU-REBOOT ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}8${BICyan}] REBOOT ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}9${BICyan}] RESTART ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}10${BICyan}] BACKUP/RESTORE ${BICyan}${BIYellow}${BICyan}${NC}"   
echo -e "     ${BICyan}[${BIWhite}11${BICyan}] ADD-HOST/DOMAIN ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}12${BICyan}] GEN-SSL ${BICyan}${BIYellow}${BICyan}${NC}"       
echo -e "     ${BICyan}[${BIWhite}13${BICyan}] EDIT-BANNER ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}14${BICyan}] CEK-STATUS ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}15${BICyan}] CEK-TRAFIK ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}16${BICyan}] CEK-SPEED ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}17${BICyan}] CEK-BANDWIDTH ${BICyan}${BIYellow}${BICyan}${NC}"
#echo -e "     ${BICyan}[${BIWhite}18${BICyan}] CEK-USAGE-RAM ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}18${BICyan}] LIMIT-SPEED ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}19${BICyan}] WEBMIN ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}20${BICyan}] INFO-SCRIPT ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}21${BICyan}] CLEAR-LOG ${BICyan}${BIYellow}${BICyan}${NC}" 
#echo -e "     ${BICyan}[${BIWhite}99${BICyan}] UPDATE ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}x${BICyan}]  EXIT ${BICyan}${BIYellow}${BICyan}${NC}"  
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"
echo -e " ${BICyan}┌─────────────────────────────────────┐${NC}"
echo -e " ${BICyan}│  Version      ${NC} : $sem Last Update"
echo -e " ${BICyan}│  User          :\033[1;36m $Nama_Issued_License \e[0m"
echo -e " ${BICyan}│  Expiry script${NC} : ${BIYellow}$(cat /etc/${Auther}/license-remaining-active-days.db)${NC} Days"
echo -e " ${BICyan}└─────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; tendang ;;
7) clear ; autoreboot ;;
8) clear ; reboot ;;
9) clear ; restart ;;
10) clear ; menu-bckp ;;
11) clear ; addhost ;;
12) clear ; genssl ;;
13) clear ; nano /etc/issue.net ;;
14) clear ; running ;;
15) clear ; cek-trafik ;;
16) clear ; cek-speed ;;
17) clear ; cek-bandwidth ;;
#18) clear ; cek-ram ;;
18) clear ; limitspeed ;;
19) clear ; webmin ;;
20) clear ; cat /root/log-install.txt ;;
21) clear ; clearlog ;;
#99) clear ; update ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
