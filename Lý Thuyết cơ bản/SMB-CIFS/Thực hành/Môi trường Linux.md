# Mục lục
[I. Chuẩn bị 🧵](#I)

[II. Thực hành 🖥️](#II)

 - [1. Máy Windows share và máy CentOS nhận 💻](#II.1)
 - [2. Máy CentOS share và máy Windows nhận 💻](#II.2)
    - [2.1 Share cho tất cả người dùng (without passwd)](#2.1) 
    - [2.2 Share cho chính xác từng người dùng (with passwd)](#2.2)
 - [3. Chứng thực Samba chạy trên nền SMB/CIFS](#II.3)

[III. Tài liệu tham khảo](#III)
___

# <a name="I" >I. Chuẩn bị 🧵</a>
 - 2 máy, 1 máy chạy Windows 10 pro, 1 máy chạy CentOS 7, cả 2 đều được kết nối với Internet.
 - Trên máy chạy CentOS 7 ta cần cài đặt thêm gói dịch vụ Samba để có thể tham gia chia sẻ với máy chạy Windows bằng SMB/CIFS.
    - Sử dụng câu lệnh: `yum install samba* -y`

# <a name="II" >II. Thực hành 🖥️</a>
## <a name="II.1" >1. Máy Windows share và máy CentOS nhận 💻</a>
Trên máy CentOS, ta cần tạo 1 thư mục để làm điểm mount, sử dụng `mkdir` theo cách của bạn để tạo 1 thư mục. Ví dụ mình dùng:
```sh
mkdir -p /share1
```

Tiến hành mount thư mục đã share từ windows về máy. Sử dụng câu lệnh `mount`:
```sh
mount.cifs //<name/IP_WinPC>/<folder_share> /home/<user_name>/<folder_name> -o user=<user_name_WinPC>
```
Tại bài viết này mình chưa tìm được cách để tạo user/passwd trên máy windows khi chia sẻ file, mà mới chỉ phân quyền đọc/ghi cho file được chia sẻ. Nên có thể lược bỏ `-o user=`.
ví dụ:
```sh
mount.cifs //172.16.5.4/test /share1
```

Đó là mount mềm, để mount point không bị mất sau khi reboot, thêm câu lệnh sau vào trong file cấu hình `/etc/fstab`
```sh
//WIN_PC_IP/<share name>    /<mntpoint>   cifs  _netdev,credentials=/root/.credfile,dir_mode=0755,file_mode=0755,uid=500,gid=500 0 0
```

![image](https://user-images.githubusercontent.com/79830542/178215516-dd093bf3-ef7b-41df-b7c5-546172cb4799.png)

Mount thành công thư mục `test` trên Windows vào điểm mount `/share1` trên CentOS 7

## <a name="II.2" >2. Máy CentOS share và máy Windows nhận 💻</a>

_Các bước bên dưới trừ bước cuối cùng là phải thực hiện sau cùng. Các bước còn lại có thể tuỳ ý thực hiện trước sau theo sở thích, tình huống._

### <a name="2.1" >2.1 Share cho tất cả người dùng (without pass)</a>

- B1: Tạo thư mục để share. `mkdir -p /share/everyone/` 
- B2: thay đổi quyền cho thư mục vừa tạo, ở đây mình để full quyền: `chmod -R 0777 /share/everyone`
- B3: thay đổi chủ sở hữu cho thư mục vừa tạo, để ai cũng có quyền đọc ghi vào thư mục đó: `chown -R nobody:nobody /share/everyone`
- B4: xin chuyển quyền quản lý từ SELinux sang cho samba quản lý để từ samba ta có thể điều khiển các quyền của thư mục vừa tạo: `chcon -t samba_share_t /share/everyone -R`
- B5: chỉnh sửa trong file config của samba `vi /etc/samba/smb.conf`
    ```sh
    [global]
            workgroup = WORKGROUP 
            security = user
            passdb backend = tdbsam
            printing = cups
            printcap name = cups
            load printers = yes
            cups options = raw
            map to guest = bad user
    [Everyone]
            comment = Everyone can access
            path = /share/everyone
            writable = yes
            browsable = yes
            guest only = yes
            create mode = 0777
            directory mode = 0777
    ```
    Ta có thể xoá file cũ đi hoặc thêm mục [Everyone] vào cuối file config và chỉnh sửa 1 chút trong mục [global].
    
 - B6: lưu lại file config rồi chạy lệnh `testparm` 
     - Ta sẽ nhận được thông báo như này, rồi nhấn `Enter` để tiếp tục
     - ![image](https://user-images.githubusercontent.com/79830542/178220369-296d9d75-de44-4198-9426-1a3918de93cb.png)
 - B7:  khai báo với `firewall` để thông qua các port mà samba cần để để sử dụng.
    ```sh
    firewall-cmd --permanent --zone=public --add-port=137/tcp
    firewall-cmd --permanent --zone=public --add-port=138/tcp
    firewall-cmd --permanent --zone=public --add-port=139/tcp
    firewall-cmd --permanent --zone=public --add-port=445/tcp
    firewall-cmd --permanent --zone=public --add-port=901/tcp
    firewall-cmd --reload
    or we can use simple:
    firewall-cmd --permanent --zone=public --add-service=samba
    firewall-cmd --reload
    ```
  - B8: Cuối cùng ta có thể khởi động dịch vụ samba bằng 2 câu lệnh
      - `systemctl start smb` và `systemctl start nmb`
      - Luôn nhớ sau khi thay đổi file config thì cần `restart` lại dịch vụ của samba để có thể áp dụng được những config mới đó.
      - Ngoài ra bạn có thể dùng 2 câu lệnh `systemctl enable smb.service` và `systemctl enable nmb.service` để samba tự khởi động lại khi reboot hệ thống.

  - B9: trên máy windows có thể dùng bảng điều khiển `Network` trong File Explorer. Hoặc mở hộp thoại `Run` rồi nhập `\\ip máy share` , click `Ok`
      - <img src="https://user-images.githubusercontent.com/79830542/178223076-cc37db81-6a5c-4cde-b86d-55bdff076e76.png" width="500">

### <a name="2.2" >2.2 Share cho chính xác từng người dùng (with passwd)</a>
- B1: Tạo 1 thư mục để chia sẻ: `mkdir -p /samba/secure`
- B2: thay đổi quyền cho thư mục vừa tạo: `chmod -R 0755 /samba/secure`, việc thay đổi quyền này thì ta có thể tự xem thêm trên internet.
- B3: tạo user và group user để dễ dàng quản lý hơn.
    - 3.1: Tạo group user `groupadd smb-group`
    - 3.2: Tạo user `useradd <tên_user>` vd: useradd smb-user1.
    - 3.3: add user vừa tạo vào trong group mà ta muốn `usermod <tên_user> -aG <tên_group>` vd: usermod smb-user1 -aG smb-group. Muốn kiểm tra xem ta đã tạo đúng chưa thì dùng câu lệnh `cat /etc/group`
    - 3.4: tạo passwd cho từng user để không bị nhầm lẫn khi truy cập: `smbpasswd -a <tên_user>`. Nhập lần đầu để khởi tạo, lần 2 để xác thực, trong quá trình nhập sẽ không hiện số ký tự vừa nhập, bạn cần phải ghi nhớ chúng.
    - ![image](https://user-images.githubusercontent.com/79830542/178227421-a950ce75-7bec-4b20-b2ce-8de3a7755ec5.png)

 - B4: Sau khi có group user tiến hành đổi quyền thư mục cần share cho group user đó `chown -R <tên_user>:<tên_group_user> /đường_dẫn_thư_mujc` vd: chown -R smb-user1:smb-group
 - B5: Xin chuyển quyền quản lý từ SELinux sang cho Samba `chcon -t samba_share_t /samba/secure -R`
 - B6: chỉnh sửa file config `/etc/samba/smb.conf`, thêm phần khai báo sau:
    ```sh 
    [Secure]
        comment = secure share
        path = /samba/secure
        writable = yes
        browsable = yes
        guest only = no
        valid users = @smb-group
        create mask = 0755
        directory mask = 0755
        read only = No
     ```
Lưu file và thoát
  - B7: chạy lệnh `testparm` 
  - B8: restart lại các dịch vụ của smb
  - B9: truy cập vào thư mục đã share ở trên từ máy Windows, lúc này ta sẽ cần phải nhập tài khoản mật khẩu đã thiết lập ở trên để có thể truy cập được. Nếu đã truy cập được mà khôn thể tao thác bên trong thư mục thì có thể bạn đã bỏ qua B5.
      - Kết quả như hình dưới
      - <img src="https://user-images.githubusercontent.com/79830542/178231467-20ee528b-9256-4d57-a302-44f548c99d29.png" width="500">

## <a name="II.3" >3. Chứng thực Samba chạy trên nền SMB/CIFS</a>
Trên CentOS cũng có phầm mềm Wireshark hỗ trợ việc bắt gói tin. Cài đặt Wireshark ta dùng: ` yum install wireshark -y`.
<img src="https://user-images.githubusercontent.com/79830542/178232721-147ccb89-d32f-4a13-a434-5de0a295a1dc.png" width="500">

May mắn, wireshark trên Linux có hỗ trợ GUI, cài thêm GUI cho wireshark bằng câu lệnh `yum install wireshark-gnome -y`

Khởi chạy wireshark với GUI, chạy câu lệnh: `wireshark &` 

Ta dùng bộ lọc trên GUI để dễ dàng bắt các gói tin được vận chuyển qua SMB, như hình dưới ta thu được kết quả 2 máy CentOS (vlan16-172.16.1.4) và Windows (vlan16-172.16.5.5) thực hiện việc chia sẻ file thông qua giao thức SMBv2

<img src="https://user-images.githubusercontent.com/79830542/178244030-6c8c6f97-3d28-4674-8167-05e5b43f476e.png" width="">

# <a name="III" >III. Tài liueej tham khảo</a>
1. [Clip trên youtube](https://www.youtube.com/watch?v=-zALd9F8r40&t=2s)
2. [Tài liệu tiếng Anh](https://www.gonscak.sk/?p=180)
3. [Using wireshark on centos 7](https://opensource.com/article/20/1/wireshark-linux-tshark)
 
