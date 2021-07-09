#!/bin/bash
echo "run this as root requires full x11 system either as yum install xorg-* -y or other fully enabled x11 "
yum install qemu-img caja mesa-* wget git -y

sudo dnf -y install dnf-plugins-core
 sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo


 sudo dnf install docker-ce docker-ce-cli containerd.io -y

systemctl start docker

systemctl enable docker 


echo "# as root:"
echo "* you should have something like this before connecting"
echo '
──╼ #xhost 
access control enabled, only authorized clients can connect
SI:localuser:root
SI:localuser:c4pt
'

echo '
# when running this as privileged with /sbin/init 
# system will hook PID 1 (Crtl-Alt-F3) and or (Crtl-Alt-F4) then back to (Crtl-Alt-F1) to release XDM login for fedora-mac
echo '
sleep 10s


git clone https://github.com/c4pt000/Docker-bigSur
cd Docker-bigSur
tar -xvf OSX-KVM.tar.gz
chmod +x fetch-macOS-v2.py
./fetch-macOS-v2.py --action download -n Latest

qemu-img convert Latest.dmg -O raw BaseSystem.img

rm -rf Latest.*
 
qemu-img create -f raw ./mac_hdd_ng.img 256G

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

ssh -p 2022 -Y root@172.17.0.2
