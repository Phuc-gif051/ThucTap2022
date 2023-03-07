## Nội dung chính

[Tổng quan](#tổng-quan)

[]()


## Tổng quan

KVM cũng cung cấp các mô hình mạng trong việc ảo hóa network. Các mô hình bao gồm:

- NAT (Network Address Translation)
- Host-only
- Linux-bridge

Trong đó Linux-bridge là một mô hình ảo hóa mạng được hỗ trợ bởi KVM. Linux bridge là một công nghệ cung cấp switch ảo để giải quyết vấn đề ảo hóa Network bên trong các máy vật lý.

<p align="center">
 <img src="../Images/linux-bridge.png" width="">
</p>

Chúng ta có thể thấy rằng có một con switch được tạo ra nằm bên trong của máy vật lý. Các VM kết nối đến đây để có thể liên lạc được với nhau. Nếu muốn liên lạc ra bên ngoài ta có thể kết nối con switch này với card mạng trên máy vật lý của ta (giống như ta dùng dây kết nối switch với router). Ta có thể kết nối switch với 1 hoặc nhiều port vật lý.

**_Chú ý ta không thể kết nối switch ảo với card wireless_**

Một số khái niệm:

- **TAP**: là các interface để VM kết nối với bridge do linux bridge tạo ra
- **vNIC**: là card ảo cho các máy ảo
- **Physical Switch Port**: là cổng kết nối vật lý của host
- **Virtual Swtich Port**: là port ảo tồn tại trên virtual switch. Cả virtual NIC (vNIC) và virtual port đều là phần mềm, nó liên kết với virtual cable kết nối vNIC
- **MAC Learning DB**: lưu trữ các mac table của các host đã giao tiếp.
- **forward data**: chuyển tiếp dữ liệu từ máy ảo tới bridge.

Các tính năng chính:

- STP: Spanning Tree Protocol – giao thức chống lặp gói tin trong mạng
- VLAN: chia switch (do Linux Bridge tạo ra) thành các mạng LAN ảo, cô lập traffic giữa các VM trên các - VLAN khác nhau của cùng 1 switch
- FDB (forwarding database): chuyển tiếp các gói tin theo database để nâng cao hiệu năng switch. Database lưu các địa chỉ MAC mà nó học được. Khi gói tin Ethernet đến, bridge sẽ tìm kiếm trong database có chứa MAC address không. Nếu không, nó sẽ gửi gói tin đến tất cả các cổng (broadcast)

## Thực hành với Linux-bridge

## 2.1. Cài đặt công cụ làm việc với Linux Bridge

Linux Bridge được hỗ trợ từ phiên bản kernel 2.4 trở lên. Cài đặt công cụ quản lý Linux Bridge:

```sh
# Centos
sudo yum install bridge-utils

# Ubuntu

```

### BRIDGE MANAGEMENT

|ACTION|BRCTL|BRIDGE|
|-|-|-|
|creating bridge|`brctl addbr <bridge>`| |
|deleting bridge|`brctl delbr <bridge>`| |
|add interface (port) to bridge| `brctl addif <bridge> <ifname>`| |
|delete interface (port) on bridge |`brctl delif <brname> <ifname>`|  |


### FDB MANAGEMENT

|ACTION|BRCTL|BRIDGE|
|-|-|-|
|Shows a list of MACs in FDB|`brctl showmacs <bridge>`|`bridge fdb show`|
|Sets FDB entries ageing time|`brctl setageingtime  <bridge> <time>`| |
|Sets FDB garbage collector interval|`brctl setgcint <brname> <time>`| |
|Adds FDB entry| |`bridge fdb add dev <interface> [dst, vni, port, via]`|
|Appends FDB entry| |`bridge fdb append` (parameters same as for fdb add)|
|Deletes FDB entry| |`bridge fdb delete`(parameters same as for fdb add)|

### STP MANAGEMENT

|ACTION|BRCTL|BRIDGE|
|-|-|-|
|Turning STP on/off|`brctl stp <bridge> <state>`| |
|Setting bridge priority|`brctl setbridgeprio <bridge> <priority>`| |
|Setting bridge forward delay|`brctl setfd <bridge> <time>`| |
|Setting bridge 'hello' time|`brctl sethello <bridge> <time>`| |
|Setting bridge maximum message age|`brctl setmaxage <bridge> <time>`| |
|Setting cost of the port on bridge|`brctl setpathcost <bridge> <port> <cost>`|`bridge link set dev <port> cost <cost>`|
|Setting bridge port priority|`brctl setportprio <bridge> <port> <priority>`|`bridge link set dev <port> priority <priority>`|
|Should port proccess STP BDPUs| |`bridge link set dev <port > guard [on, off]`|
|Should bridge might send traffic on the port it was received||`bridge link set dev <port> hairpin [on,off]`|
|Enabling/disabling fastleave options on port| |`bridge link set dev <port> fastleave [on,off]`|
|Setting STP port state||`bridge link set dev <port> state <state>`|

### VLAN MANAGEMENT

|ACTION|BRCTL|BRIDGE|
|-|-|-|
|Creating new VLAN filter entry||`bridge vlan add dev <dev> [vid, pvid, untagged, self, master]`|
|Delete VLAN filter entry||`bridge vlan delete dev <dev>` (parameters same as for vlan add)|
|List VLAN configuration||`bridge vlan show`|

Nguồn : https://github.com/hocchudong/thuctap012017/blob/master/TamNT/Virtualization/docs/Virtual_Switch/1.Linux-Bridge.md



## Tài liệu tham khảo

<https://github.com/lamth/Report-MDT>

<https://github.com/hocchudong/thuctap012017/blob/master/TamNT/Virtualization/docs/Virtual_Switch/1.Linux-Bridge.md>

<https://github.com/hocchudong/Linux-bridge>
