#!/bin/bash
# Source Script Arz

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
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

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
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear
function trialssh(){
clear
domen=`cat /etc/xray/domain`
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`
clear
IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
udparz="$(cat /root/log-install.txt | grep -w "UDP CUSTOM" | cut -d: -f2)"
ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat /root/log-install.txt | grep -w "Squid" | cut -d: -f2)"
OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`


Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="0"
Pass=1
echo Ping Host &> /dev/null
echo Create Akun: $Login &> /dev/null
sleep 0.5
echo Setting Password: $Pass &> /dev/null
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`

if [[ ! -z "${PID}" ]]; then
echo -e "${BIBlue}═════SSH ACCOUNTS═════${NC}"
echo -e "${BIBlue}════════════════════${NC}"
echo -e "Username   : $Login" 
echo -e "Password   : $Pass"
echo -e "Expired On : $exp" 
echo -e "${BIBlue}════════════════════${NC}"
echo -e "IP     : $IP" 
echo -e "Host       : $domen" 
echo -e "OpenSSH    : $opensh"
echo -e "Dropbear   : $db" 
echo -e "SSH-WS     : $portsshws" 
echo -e "SSH WS SSL : $wsssl" 
echo -e "SSL/TLS    : $ssl" 
echo -e "UDP CUSTOM : 1-65535"
echo -e "UDPGW      : 7100-7300" 
echo -e "${BIBlue}════════════════════${NC}"
echo -e "Payload WS"
echo -e "GET / HTTP/1.1[crlf]Host: $domen[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]"
echo -e "${BIBlue}════════════════════${NC}"
echo -e "Payload WSS"
echo -e "GET wss://$domen HTTP/1.1[crlf]Host: bug.com[crlf]Connection: Arz-Alive[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]"
echo -e "${BIBlue}════════════════════${NC}"
echo -e "${BICyan} Enjoy our Arz Auto Script Service${NC}" 
else
clear
echo -e "${BIBlue}═════SSH ACCOUNTS═════${NC}"
echo -e "${BIBlue}════════════════════${NC}"
echo -e "Username   : $Login" 
echo -e "Password   : $Pass"
echo -e "Expired On : $exp" 
echo -e "${BIBlue}════════════════════${NC}"
echo -e "IP     : $IP" 
echo -e "Host       : $domen" 
echo -e "OpenSSH    : $opensh"
echo -e "Dropbear   : $db" 
echo -e "SSH-WS     : $portsshws" 
echo -e "SSH WS SSL : $wsssl" 
echo -e "SSL/TLS    : $ssl" 
echo -e "UDP CUSTOM : 1-65535"
echo -e "UDPGW      : 7100-7300" 
echo -e "${BIBlue}════════════════════${NC}"
echo -e "Payload WS"
echo -e "GET / HTTP/1.1[crlf]Host: $domen[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]"
echo -e "${BIBlue}════════════════════${NC}"
echo -e "Payload WSS"
echo -e "GET wss://$domen HTTP/1.1[crlf]Host: bug.com[crlf]Connection: Arz-Alive[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]"
echo -e "${BIBlue}════════════════════${NC}"
echo -e "${BICyan} Enjoy our Arz Auto Script Service${NC}" 
fi
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
}
function trialvmess(){
domain=$(cat /etc/xray/domain)
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessworry$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmesskuota$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "\033[0;34m═══════XRAY/VMESS═══════\033[0m"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "id             : ${uuid}"
echo -e "alterId        : 0"
echo -e "Security       : auto"
echo -e "Network        : ws"
echo -e "Path           : /vmess"
echo -e "Path           : /worryfree" 
echo -e "Path           : http://bug/worryfree" 
echo -e "Path           : /v2ray" 
echo -e "ServiceName    : vmess-grpc"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link TLS       : ${vmesslink1}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link none TLS  : ${vmesslink2}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link gRPC      : ${vmesslink3}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Expired On     : $exp"
echo -e "\033[0;34m══════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

function trialvless(){
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /etc/xray/domain)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\## '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\## '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
clear
echo -e "\033[0;34m═══════XRAY/VLESS═══════${NC}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "ID             : ${uuid}"
echo -e "Encryption     : none"
echo -e "Network        : ws"
echo -e "Path           : /vless"
echo -e "Path           : vless-grpc"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link TLS       : ${vlesslink1}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link none TLS  : ${vlesslink2}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link gRPC      : ${vlesslink3}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Expired On     : $exp"
echo -e "\033[0;34m══════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

function trialtrojan(){
domain=$(cat /etc/xray/domain)
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\# '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\# '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@bug.com:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
clear
echo -e "$BIBlue══════XRAY/TROJAN══════${NC}"
echo -e "\033[0;34m═════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Host/IP        : ${domain}"
echo -e "Port TLS       : 443"
echo -e "Port gRPC      : 443"
echo -e "Key            : ${uuid}"
echo -e "Path           : /trojan-ws"
echo -e "ServiceName    : trojan-grpc"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link WS       : ${trojanlink}"
echo -e "\033[0;34m══════════════════════\033[0m"
echo -e "Link gRPC      : ${trojanlink1}"
echo -e "\033[0;34m═══════════════════════\033[0m"
echo -e "Expired On     : $exp"
echo -e "\033[0;34m═══════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

function trialssws(){
domain=$(cat /etc/xray/domain)
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#ssws$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@isi_bug_disini:443?path=ss-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=ss-grpc&sni=bug.com#${user}"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "\033[0;34m═══════XRAY/SSWS════════${NC}"
echo -e "\033[0;34m════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Port TLS       : 443"
echo -e "Port gRPC      : 443"
echo -e "Password       : ${uuid}"
echo -e "Ciphers        : ${cipher}"
echo -e "Network        : ws/grpc"
echo -e "Path           : /ss-ws"
echo -e "ServiceName    : ss-grpc"
echo -e "\033[0;34m════════════════════\033[0m"
echo -e "Link TLS       : ${shadowsockslink}"
echo -e "\033[0;34m═════════════════════\033[0m"
echo -e "Link gRPC      : ${shadowsockslink1}"
echo -e "\033[0;34m═════════════════════\033[0m"
echo -e "Expired On     : $exp"
echo -e "\033[0;34m═════════════════════\033[0m"
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

clear
echo -e "┌────────────────────────────────────────────┐" | lolcat
echo -e "│                 TRIAL MENU                 │" | lolcat
echo -e "└────────────────────────────────────────────┘" | lolcat
echo -e " ┌───────────────────────────────────────────────┐" | lolcat
echo -e "     ${BICyan}[${BIGreen}a${BICyan}]${BIGreen} Trial SSH Account   ${NC}   "
echo -e "     ${BICyan}[${BIGreen}b${BICyan}]${BIGreen} Trial Vmess Account   ${NC}   "
echo -e "     ${BICyan}[${BIGreen}c${BICyan}]${BIGreen} Trial Vless Account   ${NC}   "
echo -e "     ${BICyan}[${BIGreen}d${BICyan}]${BIGreen} Trial Trojan Account   ${NC}   "
echo -e "     ${BICyan}[${BIGreen}e${BICyan}]${BIGreen} Trial Shadowsocks Account  ${NC}    "
echo -e "     ${BICyan}[${BIGreen}x${BICyan}]${BIGreen} Exit Menu  ${NC} "
echo -e " └───────────────────────────────────────────────┘" | lolcat
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
a) clear ; trialssh ;;
b) clear ; trialvmess ;;
c) clear ; trialvless ;;
d) clear ; trialtrojan ;;
e) clear ; trialssws ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back on menu" ; sleep 1 ; menu ;;
esac
