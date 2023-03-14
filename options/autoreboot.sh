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

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
if [ ! -e /usr/bin/reboot ]; then
echo '#!/bin/bash' > /usr/bin/reboot
echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/bin/reboot
echo 'waktu=$(date +"%T")' >> /usr/bin/reboot
echo 'echo "Server successfully rebooted on the date of $tanggal hit $waktu." >> /root/log-reboot.txt' >> /usr/bin/reboot
echo '/sbin/shutdown -r now' >> /usr/bin/reboot
chmod +x /usr/bin/reboot
fi

echo -e ""
echo -e "------------------------------------" | lolcat
echo -e "             AUTO REBOOT" | lolcat
echo -e "------------------------------------" | lolcat
echo -e ""
echo -e "  ${BICyan}[${BIGreen}1${BICyan}]${BIGreen}  Auto Reboot 30 Minutes${NC}"
echo -e "  ${BICyan}[${BIGreen}2${BICyan}]${BIGreen}  Auto Reboot 1 Hours${NC}"
echo -e "  ${BICyan}[${BIGreen}3${BICyan}]${BIGreen}  Auto Reboot 12 Hours${NC}"
echo -e "  ${BICyan}[${BIGreen}4${BICyan}]${BIGreen}  Auto Reboot 24 Hours${NC}"
echo -e "  ${BICyan}[${BIGreen}5${BICyan}]${BIGreen}  Auto Reboot 1 Weeks${NC}"
echo -e "  ${BICyan}[${BIGreen}6${BICyan}]${BIGreen}  Auto Reboot 1 Mount${NC}"
echo -e "  ${BICyan}[${BIGreen}7${BICyan}]${BIGreen}  Turn Off Auto Reboot${NC}"
echo -e "  ${BICyan}[${BIGreen}0${BICyan}]${BIGreen}  Back To Menu${NC}"
echo -e "  ${BICyan}[${BIGreen}x${BICyan}]${BIGreen}  Exit${NC}"
echo -e "------------------------------------" | lolcat
echo -e ""
read -p "     Please Input Number  [1-7 or x] :  "  autoreboot
echo -e ""
case $autoreboot in
1)
echo "*/30 * * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot : On"
echo -e "      AutoReboot Every : 30 Minutes"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
2)
echo "0 * * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot : On"
echo -e "      AutoReboot Every : 1 Hours"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
3)
echo "0 */12 * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot : On"
echo -e "      AutoReboot Every : 12 Hours"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
4)
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot : On"
echo -e "      AutoReboot Every : 24 Hours"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
5)
echo "0 0 */7 * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot : On"
echo -e "      AutoReboot Every : 1 Weeks"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
6)
echo "0 0 1 * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot : On"
echo -e "      AutoReboot Every : 1 Mount"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
7)
rm -fr /etc/cron.d/auto_reboot
echo "" > /root/log-reboot.txt
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      AutoReboot Turned Off"
echo -e ""
echo -e "======================================"
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
;;
0)
menu
;;
x)
exit
;;
*)
echo "Please enter an correct number"
;;
esac
read -n 1 -s -r -p "Press any key to back on menu"

menu
