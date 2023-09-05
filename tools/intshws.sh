#!/bin/bash
#installer Websocker tunneling 

cd

#Install Script Websocket-SSH Python
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/arzvpn/Arzv/main/tools/ws-stunnel
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/arzvpn/Arzv/main/tools/ws-dropbear

#izin permision
chmod +x /usr/local/bin/ws-stunnel

#System SSL/TLS Websocket-SSH Python
wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/arzvpn/Arzv/main/tools/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service

#restart service
systemctl daemon-reload
#Enable & Start ws-stunnel service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service
