#!/bin/bash


echo "system will hook PID 1 (Crtl-Alt-F3) and or (Crtl-Alt-F4) then back to (Crtl-Alt-F1) to release XDM login for fedora-mac script will pause for 30 seconds"
sleep 30s
docker run -it --privileged  -d  -v "${PWD}/BaseSystem.img:/Bimage"     -v "${PWD}/mac_hdd_ng.img:/image"     -v "${PWD}/OSX-KVM:/opt/OSX"    -u root     --device /dev/kvm     --device /dev/snd     --rm -e "DISPLAY=${DISPLAY:-:0.0}"     -v /tmp/.X11-unix:/tmp/.X11-unix     -p 50922:10022     -p 2022:2022     -p 5900:5900     -e NOPICKER=true     -e GENERATE_SPECIFIC=true     -e DEVICE_MODEL="iMacPro1,1"     -e SERIAL="C02TW0WAHX87"     -e BOARD_SERIAL="C027251024NJG36UE"     -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451"     -e MAC_ADDRESS="A8:5C:2C:9A:46:2F"     -e WIDTH=1000     -e HEIGHT=1000     c4pt/fedora-mac     sbin/init


echo '
port 2022 has to be enabled as allow out in firewalld or ufw   pausing for 5 seconds
'
sleep 5s

echo '
the docker guest IP might not be 172.17.0.2 (sometimes it changes if other docker guests are using a virtual docker0 ip
password to login with fedora-mac as root
'
echo 'ssh -p 2022 -Y root@172.17.0.2'
sleep 10s
ssh -p 2022 -Y root@172.17.0.2
