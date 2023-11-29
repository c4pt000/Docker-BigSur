# updates 11-29-2023

# install Ventura first then once installed upgrade to Sonoma

* update to fix networking inside of SSH KVM once you login to ssh root@172.17.0.2 using fedora-mac password use this script in fedora-mac to fix iptables
* https://raw.githubusercontent.com/c4pt000/kernel-5.11.6-expSEHDsec-HAXM-cgroup-virtio-nvidia-amd-kaliwifi/master/patch-libvirt-IPTABLES-NFTABLES-UFW.sh

  ```
  wget https://raw.githubusercontent.com/c4pt000/kernel-5.11.6-expSEHDsec-HAXM-cgroup-virtio-nvidia-amd-kaliwifi/master/patch-libvirt-IPTABLES-NFTABLES-UFW.sh
  chmod +x patch-libvirt-IPTABLES-NFTABLES-UFW.sh
  ./patch-libvirt-IPTABLES-NFTABLES-UFW.sh
  close virt-manager and then reopen virtual manager from virt-manager
  change NIC to virtio see picture below
  networking should work for install

  once inside the Sonoma installer first step open a Terminal and use the following command to prevent sleep

  sudo pmset -a disablesleep 1

  ```


# adjust Network interface card to 'virtio' to install Sonoma
![s1](https://raw.githubusercontent.com/c4pt000/Docker-Sonoma/master/virtio.png)



* now supporting Sonoma
![s1](https://raw.githubusercontent.com/c4pt000/Docker-Sonoma/master/Sonoma.png)


for docker inside of a virtual machine running KVM natively notice the kvm=on,vmx extension for the processor
requires kvm_intel nested=1 in /etc/kvm.conf
and or
```
cat /etc/modprobe.d/kvm-nested.conf 
options kvm-intel nested=1
options kvm-intel enable_shadow_vmcs=1
options kvm-intel enable_apicv=1
options kvm-intel ept=1
```
```
<qemu:arg value='Penryn,vendor=GenuineIntel,kvm=on,vmx,rdtscp,+invtsc,+avx,+avx2,+aes,+xsave,+xsaveopt,+ssse3,+sse4_2,+popcnt,vmware-cpuid-freq=on,'/>
```

# 10-27-2021
# updates for macOS monterey

"not regular hackintosh on a PC"
" https://www.insanelymac.com/ "


# for docker nested functions
* 07-09-2021 forgot to write down details from when i published this from being overtired

* requires docker (and kvm.conf and kvm enabled grub.conf)
must have  iommu=pt intel_iommu=on in /etc/default/grub  on this line and vt-d i/o enabled in the bios
```
GRUB_CMDLINE_LINUX=iommu=pt intel_iommu=on ....x.x..x.x..x..x.x...x.x..x
GRUB_ENABLE_BLSCFG=false
```

followed by 
```
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```


standard stuff for KVM.conf (might require running --->        dracut -f       )
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

# to install
as root
```
wget https://raw.githubusercontent.com/c4pt000/Docker-bigSur/master/install-docker-and-bigsur.sh
chmod install-docker-and-bigsur.sh
sh install-docker-and-bigsur.sh
```
# SET A STRONG PASSWORD AND STORE IT TO PREVENT VNC/SPICE HIJACKING
![s1](https://raw.githubusercontent.com/c4pt000/Docker-bigSur/master/docker-macos-password-prevent-vnc-hijacking.png)

![s1](https://raw.githubusercontent.com/c4pt000/Docker-monterey/master/monterey-1.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/erase-drive.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-OSX/master/done.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-monterey/master/monterey-2.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-monterey/master/monterey-3.png)
![s1](https://raw.githubusercontent.com/c4pt000/Docker-monterey/master/monterey-4.png)


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
# set a strong password and store it for root

# to resume
as root
* from the Docker-bigSur directory directly to resume
* change mode with chmod +x if not already set to executable bit
```
chmod +x resume-docker-bigSur.sh
sh resume-docker-BigSur.sh
change password for root:

# passwd

```
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
# system will hook PID 1 

# use (Crtl-Alt-F3) or (Crtl-Alt-F4) to open a different tty then back to (Crtl-Alt-F1) to release XDM login for fedora-mac




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





<br>
<br>
<br>
<br>
<br>
<br>

# from here down can be ignored original post notes
# confusing detailed original instructions begin here from original post

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

