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
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`

BURIQ () {
    curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}

x="ok"


PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
rm -f /home/needupdate > /dev/null 2>&1
else
Exp=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ip | grep $MYIP | awk '{print $3}')
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

IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )

clear
echo -e " ┌─────────────────────────────────────────────────────┐" | lolcat
echo -e " │                       MAIN MENU                     │" | lolcat
echo -e " └─────────────────────────────────────────────────────┘" | lolcat
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │${BIBlue}\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\${BICyan}│${NC}"
echo -e "${BICyan} │ ${BIBlue}   \\//    \\//    \\//    \\//    \\//    \\//     ${BICyan}│${NC}"
echo -e "${BICyan} │ ${BIBlue}    \/      \/      \/      \/      \/      \/      ${BICyan}│${NC}"
echo -e "${BICyan} │  ${BIBlue}Owner AutoScript  :  ${IBlue}Arz Vpn Store" ${NC}" 
echo -e "${BICyan} │  ${BIBlue}Premium Version   :  ${BIGreen}MultiXray Arz V2${NC}" 
if [ "$cekup" = "day" ]; then
echo -e " ${BICyan}│  ${BIBlue}System Uptime     :  ${BICyan}$uphours $upminutes $uptimecek${NC}"
else
echo -e " ${BICyan}│  ${BIBlue}System Uptime     :  ${BICyan}$uphours $upminutes ${NC}"
fi
echo -e " ${BICyan}│  ${BIBlue}OS VPS            :  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` $NC
echo -e " ${BICyan}│  ${BIBlue}Memory Usage      :  ${BICyan}$uram / $tram ${NC}"
echo -e " ${BICyan}│  ${BIBlue}CPU Usage         :  ${BICyan}$cpu_usage ${NC}"
echo -e " ${BICyan}│  ${BIBlue}Current Domain    :  ${BICyan}$(cat /etc/xray/domain)${NC}"
echo -e " ${BICyan}│  ${BIBlue}IP VPS            :  ${BICyan}$IPVPS${NC}"
echo -e " ${BICyan}│  ${BIBlue}ISP VPS           :  ${BICyan}$ISPVPS${NC}"
echo -e " ${BICyan}│  ${BIBlue}REGION            :  ${BICyan}$(curl -s ipinfo.io/timezone )${NC}"
echo -e " ${BICyan}│  ${BIBlue}DATE&TIME         :  ${BICyan}$( date -d "0 days" +"%d-%m-%Y | %X" ) ${NC}"
echo -e "${BICyan} │ ${BIBlue}   /\      /\      /\      /\      /\      /\       ${BICyan}│${NC}"
echo -e "${BICyan} │ ${BIBlue}  //\\    //\\    //\\    //\\    //\\    //\\      ${BICyan}│${NC}"
echo -e "${BICyan} │${BIBlue}//\\/\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//${BICyan}│${NC}"
echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
echo -e "     ${BIBlue} SSH ${NC}: $ressh"" ${BIBlue} NGINX ${NC}: $resngx"" ${BIBlue}  XRAY ${NC}: $resv2r"" ${BIBlue} TROJAN ${NC}: $resv2r"
echo -e "     ${BIBlue}          DROPBEAR ${NC}: $resdbr" "${BIBlue} SSH-WS ${NC}: $ressshws"
echo -e " ┌─────────────────────────────────────────────────────┐" | lolcat
echo -e "     ${BICyan}[${BIGreen}1${BICyan}]${BIGreen} SSH${NC}(${GREEN}menu-ssh${NC})" 
echo -e "     ${BICyan}[${BIGreen}2${BICyan}]${BIGreen} VMESS${NC}(${GREEN}menu-vmess${NC})"    
echo -e "     ${BICyan}[${BIGreen}3${BICyan}]${BIGreen} VLESS${NC}(${GREEN}menu-vless${NC})"    
echo -e "     ${BICyan}[${BIGreen}4${BICyan}]${BIGreen} TROJAN${NC}(${GREEN}menu-trojan${NC})" 
echo -e "     ${BICyan}[${BIGreen}5${BICyan}]${BIGreen} SHADOWSOCKS${NC}(${GREEN}menu-ss${NC})"    
echo -e "     ${BICyan}[${BIGreen}6${BICyan}]${BIGreen} BACKUP/RESTORE${NC}(${GREEN}menu-backup${NC})"    
echo -e "     ${BICyan}[${BIGreen}7${BICyan}]${BIGreen} SETTINGS${NC}(${GREEN}menu-set${NC})"    
echo -e "     ${BICyan}[${BIGreen}8${BICyan}]${BIGreen} INFO-SCRIPT${NC}(${GREEN}info${NC})"  
echo -e "     ${BICyan}[${BIGreen}9${BICyan}]${BIGreen} INFO-SERVER${NC}(${GREEN}infoserv${NC})"    
echo -e "     ${BICyan}[${BIGreen}x${BICyan}]${BIGreen} EXIT MAIN MENU${NC}(${GREEN}exit${NC})"  
echo -e " └─────────────────────────────────────────────────────┘" | lolcat
DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e " │  Expiry In     : $(( (d1 - d2) / 86400 )) Days " | lolcat
}
mai="datediff "$Exp" "$DATE""
echo -e " ┌─────────────────────────────────────┐" | lolcat
echo -e " │  Version       : $(cat /opt/.ver) Last Version " | lolcat
echo -e " │  User          : $Name " | lolcat
if [ $exp \< 1000 ];
then
echo -e "   $BICyan│$NC License      : ${GREEN}$sisa_hari$NC Days Tersisa $NC"
else
    datediff "$Exp" "$DATE"
fi;
echo -e " └─────────────────────────────────────┘" | lolcat
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; menu-backup ;;
7) clear ; menu-set ;;
8) clear ; info ;;
9) clear ; infoserv ;;
99) clear ; update ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
