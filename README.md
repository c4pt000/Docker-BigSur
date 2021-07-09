# for docker nested functions
* requires docker

```
yum install qemu-img caja xorg-* mesa-* -y

sudo dnf -y install dnf-plugins-core
 sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo


 sudo dnf install docker-ce docker-ce-cli containerd.io

systemctl start docker

systemctl enable docker (for starting docker at system startup)
```

firewall ports LAN side 22, 2022, 5900 (xhost + can be dangerous along with running ssh aside from --privileged and 5900)

https://github.com/c4pt000/Docker-fedora-34-nested-docker

https://github.com/c4pt000/kernel-5.11.6-expSEHDsec-HAXM-cgroup-virtio

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

