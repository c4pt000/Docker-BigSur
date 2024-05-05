

docker run -it --privileged --net host -d \
    -v "${PWD}/mac_hdd_ng.img:/image" \
    -v "${PWD}/OSX-KVM:/opt/OSX" \
   -u root \
    --device /dev/kvm \
    --device /dev/snd \
    --rm -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -p 50922:10022 \
    -p 2022:2022 \
    -p 6900:6900 \
    -e NOPICKER=true \
    -e GENERATE_SPECIFIC=true \
    -e DEVICE_MODEL="iMacPro1,1" \
    -e SERIAL="C02TW0WAHX87" \
    -e BOARD_SERIAL="C027251024NJG36UE" \
    -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451" \
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
    sleep 10s
    ssh -X -p 2022 -Y -X 172.17.0.1
