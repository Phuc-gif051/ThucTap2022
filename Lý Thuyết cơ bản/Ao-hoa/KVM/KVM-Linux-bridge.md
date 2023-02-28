## Nội dung chính


## Tổng quan

KVM cũng cung cấp các mô hình mạng trong việc ảo hóa network. Các mô hình bao gồm:

- NAT
- Host-only
- Linux-bridge
Trong đó Linux-bridge là một mô hình ảo hóa mạng được hỗ trợ bởi KVM. Linux bridge là một công nghệ cung cấp switch ảo để giải quyết vấn đề ảo hóa Network bên trong các máy vật lý.

<p align="center">
 <img src="../Images/linux-bridge.png" width="">
</p>

Chúng ta có thể thấy rằng có một con switch được tạo ra nằm bên trong của máy vật lý. Các VM kết nối đến đây để có thể liên lạc được với nhau. Nếu muốn liên lạc ra bên ngoài ta có thể kết nối con switch này với card mạng trên máy vật lý của ta (giống như ta dùng dây kết nối switch với router). Ta có thể kết nối switch với 1 hoặc nhiều port.

Chú ý ta không thể kết nối switch ảo với card wireless do HĐH không hỗ trợ.

Trong đó:

- Bridge: tương đương với switch layer 2
- Port: tương đương với port của switch thật
- Tap (tap interface): có thể hiểu là giao diện mạng để các VM kết nối với bridge do linux bridge tạo ra
- fd (forward data): vận chuyển dữ liệu

Các tính năng chính:

- STP: Spanning Tree Protocol – giao thức chống lặp gói tin trong mạng
- VLAN: chia switch (do Linux Bridge tạo ra) thành các mạng LAN ảo, cô lập traffic giữa các VM trên các - VLAN khác nhau của cùng 1 switch
- FDB (forwarding database): chuyển tiếp các gói tin theo database để nâng cao hiệu năng switch. Database lưu các địa chỉ MAC mà nó học được. Khi gói tin Ethernet đến, bridge sẽ tìm kiếm trong database có chứa MAC address không. Nếu không, nó sẽ gửi gói tin đến tất cả các cổng (broadcast)


## Tài liệu tham khảo

<https://github.com/lamth/Report-MDT>
