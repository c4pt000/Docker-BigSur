
# requires docker qemu-img python3

* update working now (overtired didnt realize that the "OSX-KVM" submodule wasnt linked on this repo even though the folder was there)

https://github.com/c4pt000/Docker-OSX

git clone https://github.com/c4pt000/Docker-OSX



Crtl+Alt+F for fullscreen

Crtl+Alt+F again to exit


```
docker-install-run.sh

docker exec -it <vm_hash> bash

mac-install                 might take running the command two or three times to kick over
```


```
docker-run.sh

docker exec -it <vm_hash> bash

macos                 might take running the command two or three times to kick over
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
<br>
<br>
sending/receiving files with ssh "scp"
```
pushing "Xcode.xip" to user's account at folder /Users/user/Desktop

scp -P 50922 -r Xcode_12.5.xip user@172.17.0.1:/Users/user/Desktop

pulling "Xcode.xip" from guest to host to current working directory
scp -P 50922 -r user@172.17.0.1:/Users/user/Downloads/Xcode_12.5.xip Xcode_12.5.xip
```
<br>
<br>
<br>
<br>
<br>
installer with both images
```
docker run -it \
   -v "${PWD}/BaseSystem.img:/Bimage" \
    -v "${PWD}/mac_hdd_ng.img:/image" \
    -v "${PWD}/OSX-KVM:/opt/OSX" \
   -u root \
   --device /dev/snd \
    --device /dev/kvm \
    --rm -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -p 50922:10022 \
    -e NOPICKER=true \
    -e GENERATE_SPECIFIC=true \
    -e DEVICE_MODEL="iMacPro1,1" \
    -e SERIAL="C02TW0WAHX87" \
    -e BOARD_SERIAL="C027251024NJG36UE" \
    -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451" \
    -e MAC_ADDRESS="A8:5C:2C:9A:46:2F" \
    -e WIDTH=1000 \
    -e HEIGHT=1000 \
    c4pt/fedora-mac 
```


run command for installed image
```
docker run -it \
    -v "${PWD}/mac_hdd_ng.img:/image" \
    -v "${PWD}/OSX-KVM:/opt/OSX" \
   -u root \
   --device /dev/snd \
    --device /dev/kvm \
    --rm -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -p 50922:10022 \
    -e NOPICKER=true \
    -e GENERATE_SPECIFIC=true \
    -e DEVICE_MODEL="iMacPro1,1" \
    -e SERIAL="C02TW0WAHX87" \
    -e BOARD_SERIAL="C027251024NJG36UE" \
    -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451" \
    -e MAC_ADDRESS="A8:5C:2C:9A:46:2F" \
    -e WIDTH=1000 \
    -e HEIGHT=1000 \
    c4pt/fedora-mac 
```
