#!/bin/bash
# SCRIPT BY Arz

red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                 • BACKUP MENU •               ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[1]${NC} • BACKUP(${COLOR1}backup${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[2]${NC} • RESTORE(${COLOR1}restore${NC})"
echo -e " $COLOR1│$NC   ${COLOR1}[0]${NC} • BACK TO MENU $NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; backup ;;
02 | 2) clear ; restore ;;
00 | 0) clear ; menu ;;
*) clear ; menu-backup ;;
esac
