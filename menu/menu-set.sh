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

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│ $NC$COLBG1                 MENU SETTINGS                 $COLOR1 │$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[1]${NC}  • RUNNING(${COLOR1}running${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[2]${NC}  • SET BANNER"
echo -e " $COLOR1│$NC   ${COLOR1}[3]${NC}  • BANDWITH USAGE(${COLOR1}mbandwidth${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[4]${NC}  • ANTI TORRENT $sts "
echo -e " $COLOR1│$NC   ${COLOR1}[5]${NC}  • INSTALL TCP BBR(${COLOR1}menu-tcp${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[6]${NC}  • RESTART(${COLOR1}restart${NC}) "
echo -e " $COLOR1│$NC   ${COLOR1}[7]${NC}  • AUTO REBOOT(${COLOR1}autoboot${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[8]${NC}  • REBOOT(${COLOR1}reboot${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[9]${NC}  • SPEEDTEST(${COLOR1}speedtest${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[10]${NC} • LIMIT SPEED(${COLOR1}limitspeed${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[11]${NC} • WEBMIN(${COLOR1}webmin${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[12]${NC} • UPDATE SCRIPT(${COLOR1}runupdate${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[13]${NC} • CHANGE PORT(${COLOR1}change-port${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[14]${NC} • ABOUT(${COLOR1}about${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[0]${NC}  • BACK TO MENU"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "  Select menu :  "  opt
echo -e   ""
case $opt in
01 | 1) clear ; running ;;
02 | 2) clear ; nano /etc/issue.net ;;
03 | 3) clear ; mbandwith ;;
04 | 4) clear ; enabletorrent ;;
05 | 5) clear ; menu-tcp ;;
06 | 6) clear ; restart ;;
07 | 7) clear ; autoboot ;;
08 | 8) clear ; reboot ;;
09 | 9) clear ; mspeed ;;
10 | 10) clear ; limitspeed ;;
11 | 11) clear ; mwebmin ;;
12 | 12) clear ; runupdate ;;
13 | 13) clear ; change-port ;;
14 | 14) clear ; about ;;
00 | 0) clear ; menu ;;
*) clear ; menu-set ;;
esac

