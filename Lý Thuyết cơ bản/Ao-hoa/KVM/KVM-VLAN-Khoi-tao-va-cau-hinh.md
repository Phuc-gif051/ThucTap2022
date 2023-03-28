**wireshark**
sudo yum install gcc gcc-c++ bison flex libpcap-devel qt-devel gtk3-devel rpm-build libtool c-ares-devel qt5-qtbase-devel qt5-qtmultimedia-devel qt5-linguist desktop-file-utils
sudo yum install wireshark wireshark-qt wireshark-gnome

Noi luu file xml cua KVM

```sh
cd /etc/libvirt/qemu/
```

**virsh network**

file xml co ban

```xml
<network>
  <name>vlan16</name>
  <uuid></uuid>
  <forward mode='bridge'/>
  <bridge name='vlan16'/>
</network>
```

chi can khai bao the uuid, may se tu rend uuid


virsh net-define <name>.xml

virsh net-start <name>

virsh net-autostart

virsh net-list --all

ip addr show dev br10

systemctl restart network

virsh net-edit <name>

## Tai lieu tham khao

[How to configure 802.1Q VLAN Tagging on CentOS 7](https://www.snel.com/support/how-to-configure-802-1q-vlan-tagging-on-centos-7/)

[VLAN filter support on bridge](https://developers.redhat.com/blog/2017/09/14/vlan-filter-support-on-bridge#with_vlan_filtering)

[osv-on-ubuntu](https://csint.unr.edu/downloads/lesson-pdfs/08_Networking-RET.pdf)

[vlan-tagging-on-redhat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_802_1q_vlan_tagging_using_the_command_line)

[How to configure a VLAN in Linux](https://www.redhat.com/sysadmin/vlans-configuration)

[Method 2: Create KVM bridge with virsh command](https://computingforgeeks.com/how-to-create-and-configure-bridge-networking-for-kvm-in-linux/)

sudo yum -y install NetworkManager NetworkManager-libnm NetworkManager-team NetworkManager-tui NetworkManager-wifi



