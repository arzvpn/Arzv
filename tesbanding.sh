#!/bin/bash
#Script By Arz

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
hari="5"
Pass=1
echo Ping Host &> /dev/null
echo Create Akun: $Login &> /dev/null
sleep 0.5
echo Setting Password: $Pass &> /dev/null
sleep 0.5
clear
useradd -e `date -d "$masaaktif minutes" +"%Y-%m-%d %H:%M"` -s /bin/false -M $Login
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
menu-ssh
