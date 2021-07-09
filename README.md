# for docker nested functions
* requires docker
* forgot to write down details from when i published this from being overtired

as root
```
wget https://raw.githubusercontent.com/c4pt000/Docker-bigSur/master/install-docker-and-bigsur.sh
chmod install-docker-and-bigsur.sh
sh install-docker-and-bigsur.sh
```

the docker image mounts the two local hard drive images (nothing is really stored in the docker image except for the qemu-system-x86_64
unless the user adds something
```
the script creates two (blank) hard drive images locally
mac_hdd_ng.img (blank 250gb expanding volume)
BaseSystem.img (base installer for bigSur 8.5GB?)


if Docker-bigSur is erased with the two images you will lose the data off of the system

launch INSTALL_FIRST from virt-manager
then Disk Utility "Erase" 256GB volume
then reinstall bigSur
```
<br>
<br>
<br>
<br>
<br>
<br>
<br>

# the script in further detail:
# as root:

* you should have something like this before connecting
```
┌─[root@fedora]─[/home/c4pt/opt/Docker-bigSur]
└──╼ #xhost 
access control enabled, only authorized clients can connect
SI:localuser:root
SI:localuser:c4pt
```
# when running this as privileged with /sbin/init 
# system will hook PID 1 (Crtl-Alt-F3) and or (Crtl-Alt-F4) then back to (Crtl-Alt-F1) to release XDM login for fedora-mac


Fedora 34 Host (for fedora-mac)
```
yum install qemu-img wget git -y

git clone https://github.com/c4pt000/Docker-bigSur
cd Docker-bigSur
yum install qemu-img caja xorg-* mesa-* -y
tar -xvf OSX-KVM.tar.gz
chmod +x fetch-macOS-v2.py
./fetch-macOS-v2.py --action download -n Latest

qemu-img convert Latest.dmg -O raw BaseSystem.img

rm -rf Latest.*
 
qemu-img create -f raw ./mac_hdd_ng.img 256G

docker run -it --privileged  -d  -v "${PWD}/BaseSystem.img:/Bimage"     -v "${PWD}/mac_hdd_ng.img:/image"     -v "${PWD}/OSX-KVM:/opt/OSX"    -u root     --device /dev/kvm     --device /dev/snd     --rm -e "DISPLAY=${DISPLAY:-:0.0}"     -v /tmp/.X11-unix:/tmp/.X11-unix     -p 50922:10022     -p 2022:2022     -p 5900:5900     -e NOPICKER=true     -e GENERATE_SPECIFIC=true     -e DEVICE_MODEL="iMacPro1,1"     -e SERIAL="C02TW0WAHX87"     -e BOARD_SERIAL="C027251024NJG36UE"     -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451"     -e MAC_ADDRESS="A8:5C:2C:9A:46:2F"     -e WIDTH=1000     -e HEIGHT=1000     c4pt/fedora-mac     sbin/init
```

port 2022 has to be enabled as allow out in firewalld or ufw

the docker guest IP might not be 172.17.0.2 (sometimes it changes if other docker guests are using a virtual docker0 ip
password to login with fedora-mac as root
```
ssh -p 2022 -Y root@172.17.0.2
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


firewall ports LAN side 22, 2022, 5900 (xhost + can be dangerous along with running ssh aside from --privileged and 5900)

https://github.com/c4pt000/Docker-fedora-34-nested-docker

https://github.com/c4pt000/kernel-5.11.6-expSEHDsec-HAXM-cgroup-virtio



standard stuff for KVM.conf
```
cat /etc/modprobe.d/kvm.conf 
###
### This configuration file was provided by the qemu package.
### Feel free to update as needed.
###

###
### Set these options to enable nested virtualization
###


options kvm ignore_msrs=y
options kvm_intel nested=1

#options kvm_amd nested=1

options vfio_iommu_type1 allow_unsafe_interrupts=1
```
standard stuff for mounting local volumes

where /opt is a directory and localdir is a sub dir to mount on the guest
mounting physical folders use -v /opt/localdir:/opt/remotedir

# requires docker qemu-img python3

* update working now (overtired didnt realize that the "OSX-KVM" submodule wasnt linked on this repo even though the folder was there)

https://github.com/c4pt000/Docker-OSX

git clone https://github.com/c4pt000/Docker-OSX



```
passwd for root :

fedora-mac

change with passwd 
```

Crtl+Alt+F for fullscreen

Crtl+Alt+F again to exit

# requires port 2022 LAN side allow

# step 1
```
docker-install-run.sh

echo "password:   fedora-mac"

"where 172.17.0.2 is the ip of this docker image if different connect to that ip"
"ssh -p 2022 -Y root@172.17.0.2"
"fedora-mac -> password for root"
"/usr/bin/mac-install"

for macos + hda ich9 sound support

mac-install-snd

```

# once installed from step 1
```
docker-run.sh

echo "password:   fedora-mac"

"where 172.17.0.2 is the ip of this docker image if different connect to that ip"
"ssh -p 2022 -Y root@172.17.0.2"
"fedora-mac -> password for root"
"/usr/bin/macos"
or 
"/usr/bin/macos-snd"
ssh -p 2022 -Y 172.17.0.2

macos                 might take running the command two or three times to kick over

for macos + hda ich9 sound support

macos-snd
```

```

if docker: Error response from daemon: driver failed programming external connectivity on endpoint brave_wiles (ec8a48644655f0a51b73b0a8a7f5c4efd2f1d90afdc7eaa001f04f9638f38c41): Bind for 0.0.0.0:50922 failed: port is already allocated.

docker ps -a

to "docker stop <running_image>"

with port conflict

to install fresh image

docker-install-run.sh

docker exec -it <vm_machine_hash> bash

mac-install


to run image afterwards

docker-install-run.sh
docker exec -it <vm_machine_hash> bash

macos
```



![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/diskutility.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/erase-drive.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/done.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/install.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/continue.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/accept.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/install.png.mac.png)
<br>
<br>
<br>
<br>
<br>
<br>
for ssh to macOS guest

docker maps port 22 from macos when remote login is activated to 10022, docker exposes 10022 wrapped to port 50922 for the host side 
as per docker -p 50922:10022 

connecting to macOS guest running within this docker
where user is your username with "Remote login" activated

```
ssh -p 50922 user@172.17.0.1

or with X11_Forwarding enabled

ssh -p 50922 -Y user@172.17.0.1
```

sending/receiving files with ssh "scp"
```
pushing "Xcode.xip" to user's account at folder /Users/user/Desktop

scp -P 50922 -r Xcode_12.5.xip user@172.17.0.1:/Users/user/Desktop

pulling "Xcode.xip" from guest to host to current working directory
scp -P 50922 -r user@172.17.0.1:/Users/user/Downloads/Xcode_12.5.xip Xcode_12.5.xip
```

disabling "gatekeeper within macos"
```
sudo spctl --master-disable
```

