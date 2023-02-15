#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

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
#fi
#sleep 3
#echo -e "
#"
date
echo ""
sleep 1
echo -e "[ ${green}INFO${NC} ] Checking... "
sleep 2
sleep 1
echo -e "[ ${green}INFO${NC} ] Download & Install rclone... "
curl -fsSL https://rclone.org/install.sh | bash > /dev/null 2>&1
printf "q\n" | rclone config > /dev/null 2>&1
sleep 1
echo -e "[ ${green}INFO${NC} ] Downloading rclone config ... "
wget -q -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/arzvpn/Arzv2/main/backup/rclone.conf"
git clone https://github.com/magnific0/wondershaper.git &> /dev/null
cd wondershaper
sleep 1
echo -e "[ ${green}INFO${NC} ] Installing wondershaper... "
make install > /dev/null 2>&1
cd
rm -rf wondershaper > /dev/null 2>&1
echo > /home/limit

pkgs='msmtp-mta ca-certificates bsd-mailx'
if ! dpkg -s $pkgs > /dev/null 2>&1; then
sleep 1
echo -e "[ ${green}INFO${NC} ] Installing... "
apt install -y $pkgs > /dev/null 2>&1
else
sleep 1
echo -e "[ ${green}INFO${NC} ] Already Installed... "
fi
sleep 1
echo -e "[ ${green}INFO${NC} ] Creating service... "

chown -R www-data:www-data /etc/msmtprc
sleep 1
echo -e "[ ${green}INFO${NC} ] Downloading files... "
wget -q -O /usr/bin/backup "https://raw.githubusercontent.com/arzvpn/Arzv2/main/backup/backup.sh" && chmod +x /usr/bin/backup
wget -q -O /usr/bin/restore "https://raw.githubusercontent.com/arzvpn/Arzv2/main/backup/restore.sh" && chmod +x /usr/bin/restore

service cron restart > /dev/null 2>&1

rm -f /root/set-br.sh
