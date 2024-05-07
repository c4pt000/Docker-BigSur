docker run -it --net host --privileged -d \
    -v "${PWD}/mac_hdd_ng.img:/image" \
    -v "${PWD}/macOS-Sonoma-14.1.1.iso:/Bimage" \
    -v "${PWD}/:/opt/OSX-current" \
   -u root \
    --device /dev/kvm \
    --device /dev/snd \
    --rm -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -p 50922:10022 \
    -p 2022:2022 \
    -p 6900:6900 \
    -e NOPICKER=true \
    -e GENERATE_UNIQUE=true \
    -e CPU='Haswell-noTSX' \
    -e CPUID_FLAGS='kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on' \
    -e MASTER_PLIST_URL='https://raw.githubusercontent.com/sickcodes/osx-serial-generator/master/config-custom-sonoma.plist' \
    -e MAC_ADDRESS="A8:5C:2C:9A:46:2F" \
    -e WIDTH=1000 \
    -e HEIGHT=1000 \
    c4pt/fedora-mac \
    sbin/init
    echo "password:   fedora-mac"
    echo "requires port 2022 LAN side allow"
    echo ""
    echo ""
    echo ""
    echo "pausing for 30 seconds to establish ssh connection"
    sleep 30s
    ssh -X -p 2022 -Y -X 172.17.0.1
