## Nội dung chính

**_Tìm hiểu về mạng LAN ảo (VLAN), cách cấu hình để chúng có thể nói chuyện với nhau (inter vlan), và định tuyến tĩnh trên Linux_**



## I. VLAN là gì?

VLAN (Virtual Local Area Network) là một mạng tùy chỉnh, được tạo từ một hay nhiều mạng cục bộ khác (LAN). Mạng VLAN cho phép một nhóm thiết bị khả dụng trong nhiều mạng được kết hợp với nhau thành một mạng logic. Từ đó tạo ra một mạng LAN ảo (Virtual LAN), được quản lý giống như một mạng LAN vật lý.

Nếu không có mạng Virtual LAN, một broadcast được gửi từ host có thể dễ dàng đi đến mọi thiết bị mạng. Khi đó, tất cả thiết bị đều sẽ xử lý những frame đã nhận broadcast đó. Việc này sẽ làm tăng đáng kể chi phí cho CPU trên mỗi thiết bị, đồng thời làm giảm khả năng bảo mật của hệ thống.

Nếu ta đặt các interface trên các switch ở những VLAN riêng biệt, một broadcast từ host A chỉ có thể đi đến các thiết bị khả dụng ở trong cùng một Virtual LAN. Các host của Virtual LAN sẽ không hề biết về cách thức giao tiếp.

### 2. Cách hoạt động của VLAN

Cách thức hoạt động của mạng Virtual LAN:

- Các Virtual LAN ở trong mạng được xác định bằng một con số cụ thể
- Phạm vi giá trị hợp lệ là 1- 4094. Trên một switch VLAN, ta có thể chỉ định các cổng với số VLAN thích hợp.
- Tiếp đến, switch sẽ cho phép dữ liệu cần được gửi giữa các port khác nhau có cùng một Virtual LAN.
- Vì hầu hết các mạng đều có nhiều hơn là chỉ một switch duy nhất. Vì vậy, cần có một cách nào đó để có thể gửi lưu lượng giữa hai switch trong mạng. Cách đơn giản nhất chính là gán một port trên mỗi switch của Virtual LAN và chạy một cable giữa chúng.

### 3. VLAN Tagging và Standard VLAN

Các card Virtual LAN cho mạng Ethernet đều tuân theo tiêu chuẩn công nghiệp IEEE 820.1Q. Card 802.1Q bao gồm 32 bit (tương đương 4 byte) dữ liệu được chèn vào trong Ethernet frame header. Trong đó, 16 bit đầu chứa số 0x8100 được mã hóa, có nhiệm vụ kích hoạt các thiết bị Ethernet nhận dạng frame thuộc một Virtual LAN 802.1Q. Còn 12 bit cuối thì chứa số Virtual LAN, con số sẽ nằm giữa 1 đến 4094 như đã nói ở trên.

Các phương pháp hay nhất về việc quản trị Virtual LAN xác định một số loại mạng ảo tiêu chuẩn như sau:

- Native LAN: Các thiết bị Ethernet VLAN coi mọi frame không được dán nhãn (untagged frame) đều thuộc về Native VLAN. Số của native Virtual LAN theo mặc định là 1, tuy nhiên admin có thể thay đổi. Dù có thay đổi ID của native VLAN thì chúng vẫn có thể nói chuyện được với nhau, chỉ cần dạng tồn tại của chúng là `native`
- Quản lý VLAN: Hỗ trợ các kết nối từ xa của những người quản trị mạng. Có nhiều người thích sử dụng VLAN 1 để quản lý, nhưng cũng có người đặt các con số đặc biệt khác (nhằm tránh xung đột với các lưu lượng mạng khác).

### 4. Ưu điểm của VLAN

Dưới đây là một số ưu điểm tiêu biểu của mạng Virtual LAN:

- Giải quyết các vấn đề điển hình liên quan đến broadcast
- Giảm kích thước của broadcast domain
- Cho phép tạo thêm một lớp bảo mật bổ sung
- Giúp việc quản lý thiết bị trở nên đơn giản, dễ dàng hơn
- Cho phép tạo một nhóm logic các thiết bị, phân loại theo chức năng
- Có thể tạo các nhóm thiết bị được kết nối logic, có thể hoạt động như trên mạng riêng của mình
- Cho phép phân đoạn mạng dựa trên nhóm, hay chức năng
- Có thể cấu trúc mạng theo vị trí địa lý
- Đem lại hiệu suất cao hơn, độ trễ (latency) thấp hơn
- Người dùng có thể bảo vệ những thông tin nhạy cảm của mình
- Xóa bỏ ranh giới vật lý
- Tăng cường bảo mật mạng
- Phân tách các máy chủ
- Không cần thêm phần cứng, cáp, giúp tiết kiệm đáng kể chi phí
- Việc thay đổi IP subnet của người dùng sẽ nằm trong phần mềm
- Giảm số lượng thiết bị cho cấu trúc liên kết mạng
- Đơn giản hóa việc quản lý các thiết bị vật lý

### 5. Nhược điểm của VLAN

Dĩ nhiên, mọi thứ đều có mặt trái của nó. Bên cạnh rất nhiều đặc điểm nổi trội như cải thiện hiệu suất, bảo mật, phân đoạn mạng, tiết kiệm chi phí… thì virtual LAN cũng có một số nhược điểm cần phải lưu ý, như:

- Packet có thể bị rò rỉ giữa các VLAN
- Packet được inject có thể dẫn đến cyber attack
- Các mối đe dọa ở trong một hệ thống đơn lẻ có thể phát tán virus cho toàn bộ mạng
- Cần có một router bổ sung để kiểm soát workload trong những mạng lớn
- Khả năng tương tác có thể gặp vấn đề
- Một VLAN không thể chuyển tiếp lưu lượng mạng sang những VLAN khác

### 6. Ứng dụng của VLAN

- Đối với những mạng LAN có quy mô lớn, khoảng 200 thiết bị trở lên, thì việc sử dụng mạng Virtual LAN sẽ đem lại lợi ích to lớn
- Lý tưởng cho những mạng có lưu lượng truy cập cao
- Hữu ích cho những nhóm người dùng cần tính bảo mật cao, hoặc không thích mạng bị chậm do số lượng broadcast lớn
- Có thể được ứng dụng khi mạng có nhiều người dùng, nhưng lại không ở trên cùng một broadcast domain
- Có thể “biến hóa” một switch đơn nhất thành nhiều switch

### 7. Kết luận

Tóm gọn lại, ta có những ý chính của bài viết như sau:

- **Định nghĩa:** VLAN (Virtual LAN) là một mạng tùy chỉnh, được tạo từ một hay nhiều mạng cục bộ (LAN).
- **Virtual LAN** ở trong mạng được xác định bằng một con số. Giá trị của con số trên có thể nằm từ 1 đến 4094. Trên một VLAN switch, ta có thể gán các cổng với số VLAN thích hợp.
- **Virtual LAN** cung cấp cấu trúc cho phép tạo các nhóm thiết bị, kể cả khi mạng của chúng có khác nhau.
- **Điểm khác biệt lớn nhất giữa LAN và Virtual LAN:** Trong LAN, các gói mạng được broadcast đến từng thiết bị. Còn trong Virtual LAN thì các gói này chỉ được gửi đến một broadcast domain cụ thể.
- **Ưu điểm chính của Virtual LAN:** giảm kích thước của các broadcast domain.
- **Nhược điểm:** các packet được inject có thể dẫn đến cyber attack
- **Ứng dụng:** phù hợp với các mạng LAN lớn, khoảng trên 200 thiết bị

Tham khảo tại: [Mạng VLAN là gì? Cách thức hoạt động của mạng VLAN](https://vietnix.vn/vlan/#:~:text=VLAN%20(Virtual%20Local%20Area%20Network,m%E1%BB%99t%20m%E1%BA%A1ng%20LAN%20v%E1%BA%ADt%20l%C3%BD.)


## II. Khởi tạo Vlan trên Linux

### 1. Khởi tạo

Cơ chế VLAN Tagging có support trong hệ điều hành Linux, là một tính năng của kernel. Bạn có thể kiểm tra xem kernel Linux module liên quan VLAN Tagging có được bật hay chưa.

```sh
lsmod | grep 8021
```

Nếu chưa thì hãy bật module 8021q lên nhé.

```sh
modprobe 8021q
```

### 2. Tạo vlan interface

Kế đến chúng ta sẽ khởi tạo một vlan interface trên máy chủ Linux với lệnh ‘ip‘. Giả sử bạn muốn cấu hình cổng ‘eth0‘ sẽ có IP dùng vlan 123 . (Xem thêm: [Hướng dẫn sử dụng lệnh IP trên Linux](https://cuongquach.com/su-dung-lenh-ip-tren-linux.html))

```sh
ip link add link eth0 name eth0.123 type vlan id 123
```

```sh
ip link set eth0 up
```

```sh
ip link set eth0.123 up
```

```sh
ip address show eth0.123
```

```sh
2: eth0.123@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
    link/ether 00:0c:29:49:08:77 brd ff:ff:ff:ff:ff:ff
```

Lệnh trên sẽ tạo ra một card mạng ảo tên là ‘eth0.123‘ , card mạng ảo này khi xử lý packet sẽ gắn tag vlan 123 để đi ra ngoài cũng như tiếp nhận xử lý packet tag vlan id 123.

Giờ ta sẽ cấu hình VLAN IP Address cho card mạng ảo trên ‘eth0.123‘ với lệnh ‘ip‘ hoặc lệnh ‘ifconfig‘.

```sh
ip address add 192.168.123.25/255.255.255.0 dev eth0.123
```

hoặc

```sh
ifconfig eth0.123 192.168.123.25 netmask 255.255.255.0 broadcast 192.168.123.255 up
```

Kế đến bạn có thể kiểm tra ip của card ‘eth0.123‘ như sau

```sh
ip a s eth0.123
```

```sh
6: eth0.123@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 00:0c:29:49:08:77 brd ff:ff:ff:ff:ff:ff
    inet 192.168.123.25/24 brd 192.168.123.255 scope global eth0.123
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe49:877/64 scope link
       valid_lft forever preferred_lft forever
```

### 3. Xoá VLAN Interface

Bạn chỉ cần chỉ định card ảo vlan với lệnh sau sẽ xoá được card vlan tagging.

```sh
ip link del eth0.123
```

### 4. Cấu hình VLAN Interface vĩnh viễn

**CentOS**

Bạn tạo 1 file config cho card interface vlan tagging tương ứng với keyword quan trọng ‘VLAN=yes‘ tại thư mục ‘/etc/sysconfig/network-scripts/‘ (Xem thêm: [Hướng dẫn cấu hình IP tĩnh trên CentOS](https://cuongquach.com/cau-hinh-ip-tinh-tren-centos-7.html))

VD:

- Tạo file cấu hình với công cụ vi:

```sh
vi /etc/sysconfig/network-scripts/ifcfg-eth0.123
```

- Thêm cấu hình cho cho file:

```sh
DEVICE=eth0.123
BOOTPROTO=static
ONBOOT=yes
TYPE=Ethernet
VLAN=yes
NETMASK=255.255.255.0
IPADDR=192.168.123.25
```

- Áp dụng cấu hình:

```sh
systemctl restart network
```

**Debian/Ubuntu**

Ở trên OS Ubuntu thì cũng đơn giản. Truy cập đến file cấu hình của card mạng trên Ubuntu server theo đường dẫn sau:

```sh
cd /etc/netplan
```

Tùy vào từng hệ thống mà ta có file .yaml khác nhau nhưng định dạng chung mặc định là: `ID-installer-config.yaml`

Sử dụng công cụ `vi` truy cập và chỉnh sửa file cấu hình cho card mạng mà ta muốn tạo vlan.
VD:

```sh
vi /etc/netplan/00
```

- Thêm vào cấu hình sau:

```yaml
  vlans:
          ens3.4:
                  dhcp4: no
                  id: 4
                  link: ens3
                  mtu: 9000
                  addresses: [192.168.4.4/29]
```

- Áp dụng cấu hình:

```sh
netplan apply
```

**_Tham khảo tại_**

[Hướng dẫn cấu hình VLAN Tagging trên Linux Interface](https://cuongquach.com/cau-hinh-vlan-tagging-interface-tren-linux.html)

[Cấu hình bonding và multiple vlan trên Ubuntu server 18](https://fixloinhanh.com/cau-hinh-bonding-va-multiple-vlan-tren-ubuntu-server-18/)


## III. Định tuyến tĩnh trên linux

**Yêu cầu bật tính năng forward gói tin cho IPv4**

```sh
vi /etc/sysctl.conf
```

- Với CentOS thêm vào cấu hình sau:

```sh
net.ipv4.ip_forward=1
```

- Với Ubuntu thì chỉ cần bỏ chú thích (loại bỏ dấu `#`)

### 1. Sử dụng công cụ Route

- Để sử dụng được công cụ này ta cần tải về gói `net-tools`. Yêu cầu máy có internet.
- Giống như các hệ thống Unix khác hay OS khác, thì route là 1 dòng thông tin (entry) trong bảng định tuyến, hỗ trợ kernel xác định được IP packet sẽ được gửi đến đích IP theo đường nào. Với nội dung định tuyến này bạn cần kiến thức mạng căn bản (CCNA) để nắm rõ vai trò của Routing Table như trên các máy tính. Việc cấu hình route chính xác là cực kì quan trọng để hệ thống Linux của bạn có thể thông suốt phần network nhằm hoạt động ổn định được. Thường sau khi cấu hình IP tĩnh trên Linux như CentOS/Ubuntu ta sẽ kiểm tra tiếp phần routing table của hệ thống và để cấu hình route trên Linux ta sẽ dùng chương trình lệnh route trên Linux. Sau này được thay thế bằng công cụ lệnh `ip`. Với cú pháp tương tự, chỉ cần thêm tiền tố `ip`.

**Lưu ý:**

- Trước khi chỉnh sửa bảng định tuyến trên Linux, bạn phải cực kì lưu ý là nếu route thông tin sai sẽ khiến cho hệ thống không thể truy cập được và lúc này sẽ phải truy cập console của hệ thống nhằm chỉnh sửa tay. Nên cần thực sự cẩn thận và chắc chắn về thông tin route khi cấu hình, có thể show thông tin route trước để kiểm tra.
- Các thông tin route được cấu hình bằng lệnh route trên Linux chỉ có tác dụng hiện hữu trên OS vận hành cho đến khi hệ thống reboot thì sẽ mất hết thông tin route. Nếu muốn cấu hình route mang tính vĩnh viễn kể cả khi reboot OS lại vẫn còn thì cần phải tạo file cấu hình route trên Linux.

`Liệt kê thông tin bảng routing (định tuyến)`: Trước khi bạn muốn chỉnh sửa thông tin bảng định tuyến, thì tốt nhất bạn nên review lại bảng routing hiện tại trên hệ thống Linux.

```sh
route
```

```sh
Kernel IP routing table
Destination Gateway Genmask Flags Metric Ref Use Iface
default gateway 0.0.0.0 UG 0 0 0 eth0
10.12.166.0 0.0.0.0 255.255.255.0 U 0 0 0 eth0
link-local 0.0.0.0 255.255.0.0 U 1002 0 0 eth0
```

Nếu sử dụng option ‘-n‘ thì chương trình sẽ không cố phân giải ip thành hostname hay domain, mà chỉ hiển thị thông tin IP cụ thể.

```sh
~~~: route -n
Kernel IP routing table
Destination Gateway Genmask Flags Metric Ref Use Iface
0.0.0.0 10.12.166.1 0.0.0.0 UG 0 0 0 eth0
10.12.166.0 0.0.0.0 255.255.255.0 U 0 0 0 eth0
169.254.0.0 0.0.0.0 255.255.0.0 U 1002 0 0 eth0
```

`Chú thích flag:`  Với nội dung output ở trên , nếu bạn chú ý cột ‘Flags‘ sẽ thể hiện những giá trị kí tự khác nhau. Chúng có ý nghĩa gì và như thế nào , bạn hoàn toàn có thể manual lệnh route để xem thêm ‘man route‘.

|Ký hiệu | Ý nghĩa |
|:--------:|:------:|
| U | route đang up |
| H | đối tượng là host |
| G | sử dụng route này là route gateway |
| R | routing động |
| D | routing động tạo ra bởi 1 dịch vụ |
| M | được chỉnh sửa bởi 1 dịch vụ |
| A | được cài đặt bởi addrconf |
| C | cache entry |
| ! | route bị reject |

`Thêm route với 1 network`: định tuyến để truyền thông với cả một dải mạng

- Cú pháp lệnh:

```sh
route add -net {NETWORK-ADDRESS}/{BETMASK} gw {IP_GATEWAY} {INTERFACE-NAME}
```

hoặc

```sh
route add -net {NETWORK-ADDRESS} netmask {NETMASK} gw {IP_GATEWAY} {INTERFACE-NAME}
```

- Để hiển thị thông tin network đích mà bạn muốn đi tới thì bạn thay thế phần `{NETWORK_ADDRESS}` bằng thông tin network đó.

```sh
route add -net 192.168.1.0/24 gw 192.168.1.1 eth0
```

- Ta có thể chỉ định thông tin netmask đối với lớp mạng bằng cấu hình `NETMASK` cụ thể như cú pháp 2.

```sh
route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1 eth0
```

- Kiểm tra lại bảng routing.

```sh
~~~:route -n
Kernel IP routing table
Destination Gateway Genmask Flags Metric Ref Use Iface
0.0.0.0 10.12.166.1 0.0.0.0 UG 0 0 0 eth0
10.12.166.0 0.0.0.0 255.255.255.0 U 0 0 0 eth0
192.168.1.0 0.0.0.0 255.255.255.0 U 0 0 0 eth0
169.254.0.0 0.0.0.0 255.255.0.0 U 1002 0 0 eth0
```

`Thêm route với 1 host cụ thể`: định tuyến để nói chuyện với 1 ip cụ thể nào đó

- Cú pháp lệnh

```sh
route add -host {IP-ADDRESS} gw {IP_GATEWAY} {INTERFACE-NAME}
```

- Giả sử bạn muốn khai báo route muốn đến địa chỉ IP 192.168.1.5 thì hãy đi qua IP gateway 192.168.1.1 hướng card mạng eth0.

```sh
route add -host 192.168.1.5 gw 192.168.1.1 eth0
```

`Xoá route khỏi routing table của 1 network`:

- cú pháp:

```sh
route del -net {NETWORK-ADDRESS}/{SUBNET} gw {IP_GATEWAY} {INTERFACE-NAME}
```

- Ví dụ:

```sh
route del -net 192.168.1.0/24 netmask 255.255.255.0 gw 192.168.1.1 eth0
```

`Xoá route khỏi routing table của 1 host cụ thể`:

- Cú pháp:

```sh
route del -host {IP-ADDRESS} gw {IP_GATEWAY} {INTERFACE-NAME}
```

- Ví dụ:

```sh
route del -host 192.168.1.5 netmask 255.255.255.0 gw 192.168.1.1 eth0
```

`Reject route`:

- Cú pháp đối với 1 dải mạng:

```sh
route add -net 192.168.1.0/24 reject
```

- Cú pháp đối với 1 host cụ thể:

```sh
route add -host 192.168.1.5 reject
```

`Thêm default gateway route`:

- Cú pháp:

```sh
route add default gw {IP-ADDRESS} {INTERFACE-NAME}
```

- Trong đó:

IP-ADDRESS: địa chỉ IP của router gateway.
INTERFACE-NAME: chỉ định cổng card mạng sẽ đi ra ngoài đến router gateway.

- Ví dụ: router gateway của chúng ta có địa chỉ IP 192.168.1.1, vậy chúng ta muốn add default route theo card mạng eth0 thì sẽ dùng lệnh như sau.

```sh
route add default gw 192.168.1.1 eth0
```

Muốn xoá default route gateway cũng dễ như trên, chỉ cần gõ lại đúng thông tin đã sử dụng để add default route.

```sh
route del default gw 192.168.0.1 eth0
```

**Muốn cấu hình vĩnh viễn, thường là không bị mất cấu hình khi khởi động lại thì ta cần lưu lại file config**

- _Trên CentOS_: file config được lưu tại `/etc/sysconfig/network-scripts/`. Đặt tên theo định dạng `route-<name dev>`

Trong đó name dev là tên của card mạng được cấu hình routing.

- C1: lưu lại câu lệnh cấu hình (sử dụng ip route hay route đều được)
- C2: lưu lại theo định dạng:

```sh
ADDRESS0=<IP>
NETMASK0=<NETMASK NUMBER>
GATEWAY0=<IP GATEWAY>
```

- Khởi động lại dịch vụ để nhận cấu hình: `systemctl restart network`

- _Trên Ubuntu_:

- C1: sudo vi /etc/netplan/<configuration_file>.yaml

Lưu lại theo định dạng:

```sh
network:
    version: 2
    renderer: NetworkManager
    ethernets:
        enp0s3:
            dhcp4: no
            addresses:
            - 172.16.5.18/16
            gateway4: 172.16.0.1
            routes:
            - to: 10.0.2.0/24
              via: 10.0.2.1
              metric: 100
```

Lưu lại và thoát, áp dụng cấu hình: `sudo netplan apply`

- C2: sudo vi /etc/network/interfaces

Thêm vào cấu hình:

```sh
auto eth0
iface eth0 inet static
      address 10.0.2.2
      netmask 255.255.255.0
      up route add -net 10.0.3.0 netmask 255.255.0.0 gw 10.0.2.1
```



Date accessed: 24/04/2023
