# Usage

First thing to do to use this script, is making it executable with the following command:

`chmod +x CentOS_static_ip_configuration_script.sh`

Once you're sure it's executable, simply type

`./hosting_backup_script.sh`

and follow the prompt to set a static IP address on your CentOS-based machine.


# Tips

Be sure you can use __nmcli__. Even if is generally present on CentOS 7 (minimal), sometimes things just won't work out.
You know, we don't have guarantees in IT.

If you don't have it on your system, you can install it by accessing your shell and typing:

`yum install NetworkManager`

Then you can check if the service is running with:

`systemctl status NetworkManager`

and ensure it starts up at boot with:

`systemctl enable NetworkManager`


# Reference
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Networking_Guide/sec-Installing_NetworkManager.html