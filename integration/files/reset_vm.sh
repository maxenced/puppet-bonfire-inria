#!/bin/bash
#
# Reset an integration VM

if [ "$SSH_ORIGINAL_COMMAND" ];then
    P=$(echo $SSH_ORIGINAL_COMMAND|cut -d"'" -f 2|cut -d" " -f 2)
else
    P=$(echo $1|cut -d'.' -f 1)
fi
case $P in
    api|portal|mq|accounting|cache)
    ;;
    *)
        echo "bad parameter"
        exit 1
    ;;
esac

NODE=$P.integration.bonfire.grid5000.fr

virsh destroy $NODE
sleep 1
lvremove -f all/$NODE
lvcreate -s -L6G all/${NODE}.TPL -n${NODE}
virsh create /etc/libvirt/qemu/${NODE}.xml

