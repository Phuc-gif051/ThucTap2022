bridge -c vlan show
bridge vlan del vid 1 dev eth2
bridge vlan add vid 30 dev eth1

systemctl restart network

[An introduction to Linux bridging commands and features - developers.redhat.com](https://developers.redhat.com/articles/2022/04/06/introduction-linux-bridging-commands-and-features#)

[bridge - show / manipulate bridge addresses and devices](https://manpages.debian.org/unstable/iproute2/bridge.8.en.html#bridge_vlan_-_VLAN_filter_list)

[Linux VLAN-aware bridges and trunk ports - unix.stackexchange.com](https://unix.stackexchange.com/questions/556735/linux-vlan-aware-bridges-and-trunk-ports)

[Understanding VLAN tagging and untagging of ports - networkengineering.stackexchange.com](https://networkengineering.stackexchange.com/questions/24604/understanding-vlan-tagging-and-untagging-of-ports)

[Create and Configure Bridge Networking For KVM in Linux - computingforgeeks.com](https://computingforgeeks.com/how-to-create-and-configure-bridge-networking-for-kvm-in-linux/)

[How to configure a VLAN in Linux - REDHAT](https://www.redhat.com/sysadmin/vlans-configuration)

[Networking Guide - REDHAT](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_802_1q_vlan_tagging_using_the_command_line)

[How to set up a network bridge for virtual machine communication with NMTUI - REDHAT](https://www.redhat.com/sysadmin/setup-network-bridge-VM)

[Virtualization Deployment and Administration Guide - REDHAT](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/index)

[Virtualization Deployment and Administration Guide / Setting vLAN Tags - REDHAT](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-virtual_networking-setting_vlan_tags)

[Creating a Virtual Network with Virt-manager - PDF](https://csint.unr.edu/downloads/lesson-pdfs/08_Networking-RET.pdf)

[Virtual Networking - wiki.libvirt.org](https://wiki.libvirt.org/VirtualNetworking.html)

[vlan-filter-support-on-bridge - REDHAT Developer](https://developers.redhat.com/blog/2017/09/14/vlan-filter-support-on-bridge#)

[How to configure 802.1Q VLAN Tagging on CentOS 7](https://www.snel.com/support/how-to-configure-802-1q-vlan-tagging-on-centos-7/)

