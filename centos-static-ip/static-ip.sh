#!/bin/bash
#CentOS_static_ip_configuration_script
#Remember to chmod+x on this file to make it executable

#Getting new configuration info from user's input
read -p "Enter new static IP address: " ipaddr
read -p "Enter new netmask: " netmask
read -p "Enter new gateway: " gateway
read -p "Enter new dns1: " dns1
read -p "Enter new dns2: " dns2

#Getting NIC name and defining config_file
tempnic=$(nmcli dev status | grep eth)
nic=$(echo $tempnic| cut -d ' ' -f 1)

config_file="/etc/sysconfig/network-scripts/ifcfg-$nic"

#Creating configuration new_parameters array
new_ipaddr="IPADDR=$ipaddr"
new_netmask="NETMASK=$netmask"
new_gateway="GATEWAY=$gateway"
new_dns1="DNS1=$dns1"
new_dns2="DNS2=$dns2"

#Plotting new configuration and ask for confirmation
red="\033[0;31m"
nc="\033[0m"

echo -e "${red}-----------------------${nc}
${nc}Your new configuration${nc}
${red}-----------------------${nc}
$new_ipaddr
$new_netmask
$new_gateway
$new_dns1
$new_dns2
${red}-----------------------${nc}
${red}-----------------------${nc}\n"


#Getting NIC name and defining config_file
tempnic=$(nmcli dev status | grep eth)
nic=$(echo $tempnic| cut -d ' ' -f 1)

config_file="/etc/sysconfig/network-scripts/ifcfg-$nic"

#Getting user's confirmation
read -p "This will override your current settings, continue? [y/N]: " answer
answer=${answer,,}

#Checking user's confirmation and Writing new configuration to /etc/sysconfig/network-scripts/ifcfg-eth0
if [[ "$answer" =~ ^(yes|y)$ ]]; then

    #Setting new IPADDR
    if grep -Fq "ipaddr" "$config_file"
    then
    sed -i '/'ipaddr'/'c'\'"${new_ipaddr}" "$config_file"
    else
    echo $new_ipaddr >> "$config_file"
    fi

    #Setting new NETMASK
    if grep -Fq "netmask" "$config_file"
    then
    sed -i '/'netmask'/'c'\'"${new_netmask}" "$config_file"
    else
    echo $new_netmask >> "$config_file"
    fi

    #Setting new GATEWAY
    if grep -Fq "gateway" "$config_file"
    then
    sed -i '/'gateway'/'c'\'"${new_gateway}" "$config_file"
    else
    echo $new_gateway >> "$config_file"
    fi

    #Setting new DNS1
    if grep -Fq "dns1" "$config_file"
    then
    sed -i '/'dns1'/'c'\'"${new_dns1}" "$config_file"
    else
    echo $new_dns1 >> "$config_file"
    fi

    #Setting new DNS2
    if grep -Fq "dns2" "$config_file"
    then
    sed -i '/'dns2'/'c'\'"${new_dns2}" "$config_file"
    else
    echo $new_dns2 >> "$config_file"
    fi

    #Setting BOOTPROTO to static
    sed -i -e 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' "$config_file"

    #Setting ONBOOT to yes
    sed -i -e 's/ONBOOT=no/ONBOOT=yes/g' "$config_file"

    #Restarting network service
    service network restart

    #Plot ip addr output
    ip addr show $nic

else
  echo "Cancelled. No modification made to your actual configuration"
fi

exit 0
