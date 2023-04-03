## Nội dụng chính

- Khởi tạo và cấu hình vlan id sử dụng linux bridge

**wireshark**
sudo yum install gcc gcc-c++ bison flex libpcap-devel qt-devel gtk3-devel rpm-build libtool c-ares-devel qt5-qtbase-devel qt5-qtmultimedia-devel qt5-linguist desktop-file-utils
sudo yum install wireshark wireshark-qt wireshark-gnome

- Để khởi tạo được vlan thì ta cần tắt hoặc gỡ cài đặt NetworkManager. Nên tắt hơn là gỡ cài đặt.

```sh
sudo systemctl stop NetworkManager
sudo systemctl disable NetworkManager
```

- Nếu đã lỡ gỡ cài đặt thì câu lệnh sau để cài đặt lại:

```sh
sudo yum install -y NetworkManager NetworkManager-libnm NetworkManager-team NetworkManager-tui NetworkManager-wifi
```

Noi luu file xml cua KVM

```sh
cd /etc/libvirt/qemu/
```

**virsh network**

- gắn 1 bridge forward trực tiếp tới 1 interface đã được chia vlan, sử dụng luôn dải mạng và Vlan ID của interface đó.
- yêu cầu đã có 1 bridge và đã được chia vlan, có Vlan ID

- B1: tao 1 bridge cho card mạng
- B2: chia vlan cho bridge
- B3: gắn interface cho vlan bằng file xml

file xml co ban cho interface

virsh net-edit <name>

>hoặc khởi tạo file xml bằng vi/vim rồi tiếp tục các câu lệnh bên dưới.

```xml
<network>
  <name>vlan16</name>
  <uuid></uuid>
  <forward mode='bridge'/>
  <bridge name='vlan16'/>
</network>
```

>chi can khai bao the uuid, may se tu rend uuid


virsh net-define <name>.xml

virsh net-start <name>

virsh net-autostart <name>

virsh net-list --all

ip addr show dev <name>

systemctl restart network


___

You can check the connection type of a virtual machine in KVM by using the command 
`virsh domiflist <domain-name>`². This command will list all network interfaces of
a domain, including their source bridge, virtual network, and MAC address¹.

To check if a virtual machine is connected
to NAT, isolated or route network, you can use the command
`virsh dumpxml <domain-name> | grep -iE "(network|forward)"`³.
This command will show you the network type of a domain.
If it is NAT, you will see `<forward mode='nat'/>`.
If it is isolated, you will see `<forward mode='none'/>`.
If it is route, you will see `<forward mode='route'/>`³.

Source:
Conversation with Bing, 3/30/2023
[(1) Networking - KVM - Kernel-based Virtual Machine](https://www.linux-kvm.org/page/Networking) Accessed 3/30/2023.
[(2) Chapter 13. Configuring virtual machine network connections.](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_virtualization/configuring-virtual-machine-network-connections_configuring-and-managing-virtualization) Accessed 3/30/2023.
[(3) networking - KVM: isolation between different NAT networks - Unix](https://unix.stackexchange.com/questions/551105/kvm-isolation-between-different-nat-networks) Accessed 3/30/2023.

## Tai lieu tham khao

[How to configure 802.1Q VLAN Tagging on CentOS 7](https://www.snel.com/support/how-to-configure-802-1q-vlan-tagging-on-centos-7/)

[VLAN filter support on bridge](https://developers.redhat.com/blog/2017/09/14/vlan-filter-support-on-bridge#with_vlan_filtering)

[osv-on-ubuntu](https://csint.unr.edu/downloads/lesson-pdfs/08_Networking-RET.pdf)

[vlan-tagging-on-redhat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_802_1q_vlan_tagging_using_the_command_line)

[How to configure a VLAN in Linux](https://www.redhat.com/sysadmin/vlans-configuration)

[Method 2: Create KVM bridge with virsh command](https://computingforgeeks.com/how-to-create-and-configure-bridge-networking-for-kvm-in-linux/)

sudo yum -y install NetworkManager NetworkManager-libnm NetworkManager-team NetworkManager-tui NetworkManager-wifi



