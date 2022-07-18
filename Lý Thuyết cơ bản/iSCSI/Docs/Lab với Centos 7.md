# Mục lục

___

# <a name="I" >I. Chuẩn bị ⏯️</a>

Chuẩn bị tối thiểu 3 máy:

 - 2 máy chạy centos 7: 1 làm target, 1 làm initiator
 - 1 máy windows, từ win 7 trở lên để làm initiator

Cả 3 máy đều có kết nối đến internet, biết địa chỉ IPv4, và ping được cho nhau.

# <a name="II" >II. Thực hành 🖥️</a>
## <a name="II.1" >1. Cấu hình iSCSI target 💻</a>
B1: để cấu hình được thì ta cần cài gói cần thiết, dùng lệnh
```sh
sudo yum install targetd targetcli -y
```

<img src="https://user-images.githubusercontent.com/79830542/179438604-2c944a16-2261-4603-b514-6992c1bc0263.png" width="600">

B2: Chuẩn bị phân vùng để chia sẻ, ta có thể chia sẻ cả 1 ổ cứng hoặc 1 phân vùng. Nhưng như thế thì sẽ không tối ưu. Trên Centos 7 hãy tiến hành tạo 1 phân vùng bằng LVM để chia sẻ. Được xem là tối ưu nhất.
 - Xem trên máy có những phân vùng lưu trữ nào: `lsblk`

 - <img src="https://user-images.githubusercontent.com/79830542/179441293-199d60fe-9cf8-4d25-8def-670ef6d9fe4c.png" width="600">

 - Như có thể thấy trên máy hiện tại có 2 ổ cứng `vda` và `vdb`. Ổ `vda` đã được sử dụng để cài OS, ta không nên đụng chạm vào. Ổ `sdb` còn trống, ta sẽ tiến hành thao tác trên đó.

B3: Tiến hành phân vùng ổ cứng. Sử dụng công cụ `fdisk`
 -  dùng `fdisk /dev/vdb` để truy cập vào ổ vdb tiến hành phân vùng
 -  <img src="https://user-images.githubusercontent.com/79830542/179441863-0939828c-5b7b-462f-b2a1-9c1dd2477623.png" width="600">
 -  nhập `n` rồi `Enter` để tạo phân vùng mới 
 -  Nhập `p` để tạo 1 phân vùng primary, tiếp tục `Enter` lần lượt cho đến khi gặp `Last sector,...`. Tại đây ta nhập dung lượng mong muốn cho phân vùng của mình.
 -  <img src="https://user-images.githubusercontent.com/79830542/179442143-b01f131a-0942-4ac6-b2a9-46d82de9c036.png" width="600">
 -  Nhập `w` rồi `Enter` để xác nhận tạo phân vùng mới
 -  <img src="https://user-images.githubusercontent.com/79830542/179442395-7bdb9968-52fa-468e-847b-dbcf309c8cee.png" width="600">

B4: Đã có phân vùng mới `vdb1`, sử dụng LVM trên phân vùng đó
 - `pvcreate /dev/vdb1` cho phép LVM sử dụng phân vùng vdb1
 - <img src="https://user-images.githubusercontent.com/79830542/179442461-aa82ff70-8553-4cc7-b835-24826f2a4687.png" width="">
 - `vgcreate vg-iscsi /dev/vdb1` để tạo 1 volume group
 - <img src="https://user-images.githubusercontent.com/79830542/179442630-0a49a9d3-9d23-41d7-af4e-716f1db5d782.png" width="">
 - `lvcreate --size 5G --name lv-iscsi vg-iscsi` để ạo 1 logical volume nằm trong volume group vg-iscsi
 - <img src="https://user-images.githubusercontent.com/79830542/179442986-246cf14e-d10c-48de-ae78-dedc216813c4.png" width="">
_lưu ý: Ta có thể sử dụng LVM thin để tối ưu hơn, trong bài thực hành sẽ để mặc định vì dung lượng để thực hành chỉ có 5G._

B5: sử dụng `targercli` để tiến hành cấu hình iSCSI target khi đã có phân vùng LVM để share
 - `targetcli` rồi `Enter` để truy cập. Lần đầu tiên truy cập nó sẽ như hình dưới
 - <img src="https://user-images.githubusercontent.com/79830542/179443302-a62522bf-5521-44ea-a8e3-a07b942f02f3.png" width="">
 - Giờ đây ta đang ở bên trong targercli, giống như ta truy cập vào 1 ứng dụng trên windows. Nhưng ở đây sẽ không có giao diện 🙄. Nhập `ls` rồi `Enter` để xem những thứ có bên trong.
 - <img src="https://user-images.githubusercontent.com/79830542/179444237-68079a32-e44f-4d13-a29a-8f691f9e456a.png" width="">
 - Có 2 thứ chính ta cần quan tâm đó là: 
    - backstores:
     ```sh
    Block: Khối lưu trữ
    Fileio: Một kho lưu trữ tập tin là một tập tin trên hệ thống tập tin đã được tạo ra với một kích thước được xác định trước
    Pscsi: (Linux pass-through SCSI devices): Có thể hiểu là một thiết bị truyền qua SCSI trên linux
    Ramdisk: Bộ nhớ Ram disk
      ```
    - iSCSI:
    ```sh
    LUN (Logical Unit Number) : LUN là một khái niệm SCSI cho phép chúng ta chia một số lượng lớn lưu trữ thành một đoạn khá lớn. LUN là một biểu diễn logic của một đĩa vật lý. Bộ nhớ đã được gán cho bộ khởi tạo iSCSI sẽ là LUN.
    IQN (iSCSI qualified name): IQN là tên duy nhất được gán cho iSCSI target và iSCSI initiator để nhận dạng lẫn nhau.
        - Định dạng IQN  : iqn.yyyy-mm. : Tên
        - Exam: iqn.2022-07.com.linux:CentOS7

    Portal : Cổng iSCSI là một cổng mạng trong mạng iSCSI nơi mạng iSCSI khởi tạo. iSCSI hoạt động trên TCP/IP, vì vậy cổng có thể được xác định bằng địa chỉ IP. Có thể có một hoặc nhiều Portal. Mặc định là 3260

    ACL (Access Control List) : Một danh sách điều khiển truy cập sẽ cho phép bộ khởi tạo iSCSI kết nối với một mục tiêu iSCSI. ACL sẽ hạn chế quyền truy cập cho mục tiêu iSCSI để những người khởi tạo trái phép không thể kết nối
    ```
  - Dùng lệnh `cd` để di chuyển giữa các phần, như cách di chuyển giữa các thư mục của CentOS.
    
B5.1: Cấu hình trong `backstores`. `cd backstores/block`
  - <img src="https://user-images.githubusercontent.com/79830542/179445400-419be87b-494f-4410-838d-7518c594a2c0.png" width="">
  - Thư mục trống chưa có khối nào tồn tại để share. Dùng câu lệnh `create <tên block> <đường dẫn đến phân vùng>` để tạo 1 block mới
  - <img src="https://user-images.githubusercontent.com/79830542/179445596-8e7d4489-80e5-4393-b9ac-0840432e70a5.png" width="">
  - Tạo thành công block mới tên `vdisk` với đường dẫn trỏ tới phân vùng LVM đã tạo ở bên bên. 
  - Dùng `cd /iscsi` để di chuyển sang mục iscsi tiếp tục cấu hình.

B5.2: Cấu hình trong `iscsi`
  - Ngay trong /iscsi> có thể gõ `create` rồi `Enter` để tự động tạo iqn cho server. Hoặc có thể đặt tên cho iqn đó, vd: create iqn.2022-07.com.linux:target
  - <img src="https://user-images.githubusercontent.com/79830542/179446090-41280d64-19da-4415-a872-dfcc8fe2efc0.png" width="">
  - Khởi tạo tên cho server thành công, hệ thống sẽ tự tạo ra mục `tpg1` lưu trữ các cấu hình như luns, alcs, portals.
  - Truy cập đến mục `tpg1` để tiếp tục cấu hình các thông số cần thiết của máy initiator.
  - <img src="https://user-images.githubusercontent.com/79830542/179446413-bd65447a-5726-4a56-9b19-c9f4e4481cc1.png" width="600">
  - Cấu hình cho `acls` nơi chứa các iqn của máy initiator được phép truy cập. Các inistor này ta lấy ở các máy initiator
  - <img src="https://user-images.githubusercontent.com/79830542/179446902-561ab4bc-601e-40f4-bff2-336997b0a7a5.png" width="">
  - Dùng `cd` để di chuyển sang mục luns, tiếp tục cấu hình. Tại đây ta gán phần block đã tạo ở trên cho máy initiator vừa được khai báo ở mục `acls`. Dùng câu lệnh `create <đường dẫn tới block>`
  - <img src="https://user-images.githubusercontent.com/79830542/179447408-a44c931c-5587-4690-b6bd-7470c1283ee5.png" width="">
  - Lưu ý: ta có thể chỉ định block nào cho phép initiator nào kết nối, tuy nhiên ở bài thực hành đơn giản với 1 block - 1 initiator như này thì ta sẽ để hệ thống tự chỉ định như hình trên.
  - Chỉ định xong, ta di chuyển sang mục `portals` để cấu hình IPv4 và port kết nối cho phép initiator kết nối. Trước tiên phải xoá cái cũ mà máy tự tạo, dùng lệnh `delete ip_address=0.0.0.0 ip_port=3260`
  - <img src="https://user-images.githubusercontent.com/79830542/179447907-d203c9fc-bd88-4a4c-9588-7f3dc161893c.png" width="800">
  - Tạo portals mới cho target. `create ip_address=<ipv4 của máy> ip_port=3260`, hoặc chỉ cần ip_address rồi enter máy tự sinh port mặc định
  - <img src="https://user-images.githubusercontent.com/79830542/179448188-f58840da-87ce-4c68-88b6-88b8b5c399be.png" width="">

B6: cấu hình cơ bản xong, có thể dùng `exit` để thoát luôn (mặc định auto save) hoặc `saveconfig` trước rồi `exit`
 - <img src="https://user-images.githubusercontent.com/79830542/179448493-fe6eece9-34a8-4725-94e9-9ba2ab57c8dc.png" width="">
 - 
B7: 
 - Khởi động dịch vụ `systemctl start target` 
 - Khai báo với firewalld cho phép thông qua các port mà ta vừa add ở B5.2(nếu máy không có firewall thì sẽ có thông báo đỏ)
 ```sh
  firewall-cmd --permanent --add-port=3260
 ```
 - reload firewall: `firewall-cmd --reload`

🌭 Vậy là cấu hình cơ bản cho máy target đã xong, sẵn sàng cho kết nối
