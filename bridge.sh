#!/bin/sh


add_if()
{
    BRNAME=$1
    IFNAME=$2
    
    echo "adding iface:"$IFNAME
    IP=`ifconfig $IFNAME | grep "inet addr" | xargs echo | cut -d ' ' -f2 | cut -d ':' -f2`

    ifconfig $IFNAME 0.0.0.0
    brctl addif br0 $IFNAME
    echo "assigning IP($IP) to $BRNAME:$IFNAME"
    ifconfig $BRNAME:$IFNAME $IP

}


create_br()
{
    BRNAME=$1
    IP=$2
    echo "creating bridge:$BRNAME"
    brctl addbr $BRNAME
    echo "assigning IP($IP) to $BRNAME"
    ifconfig $BRNAME $IP up
}





create_br br0 192.168.2.2

add_if br0 eth0
add_if br0 eth1
#add_if br0 eth2


