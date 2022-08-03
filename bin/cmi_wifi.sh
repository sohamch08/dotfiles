systemctl stop NetworkManager
wpa_supplicant -i wlan0 -c /home/sohamch/wpa_supplicant.conf 1>/dev/null &
systemctl start dhcpcd@wlan0
