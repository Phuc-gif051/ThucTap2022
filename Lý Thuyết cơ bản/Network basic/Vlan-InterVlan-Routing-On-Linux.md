## Nội dung chính

**_Tìm hiểu về mạng LAN ảo (VLAN), cách cấu hình để chúng có thể nói chuyện với nhau (inter vlan), và định tuyến tĩnh trên Linux_**



## 1. VLAN là gì?

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

- Native LAN: Các thiết bị Ethernet VLAN coi mọi frame không được dán nhãn (untagged frame) đều thuộc về Native VLAN. Số của native Virtual LAN theo mặc định là 1, tuy nhiên admin có thể thay đổi.
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


## Khởi tạo Vlan trên Linux

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


Date accessed: 24/04/2023