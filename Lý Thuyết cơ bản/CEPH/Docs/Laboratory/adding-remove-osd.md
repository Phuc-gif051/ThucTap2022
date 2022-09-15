_**Các thao tác thực hiện dưới đây đều trên node admin**_

### <a name="1" >1. Thêm OSD</a>

 - Lấy danh sách ổ đĩa hiện có trong 1 hoặc nhiều node
 ```sh
 ceph-deploy disk list <tên hoặc địa chỉ IP của node>
 ```

 - Thực hiện zapdisk:
 ```sh
 ceph-deploy disk zap <tên hoặc IP của node> <đường dẫn đến ổ đĩa>
 
 VD:
 ceph-deploy disk zap ceph01 /dev/vdc
 ceph-deploy disk zap ceph01 /dev/vdb
 ceph-deploy disk zap ceph01 /dev/vdc
 ```
 
 - Tạo OSD với ceph-deploy:
 ```sh
 ceph-deploy osd create --data <đường dẫn đến ổ đĩa> <tên hoặc IP của node>
 VD:
 ceph-deploy osd create --data /dev/vdb ceph01
 ceph-deploy osd create --data /dev/vdc ceph01
 ```
 
 - Lấy danh sách osd hiện có trong 1 hoặc nhiều node 
 ```sh
 ceph-deploy osd list <tên hoặc IP của node>
 ```
 
 _Nếu có cảnh báo osd down and in thì chạy câu lệnh `sudo systemctl start ceph-osd@<id của osd>` để khởi chạy ổ đĩa trong cụm._
 
Tham khảo [tại đây](https://github.com/uncelvel/tutorial-ceph/blob/master/docs/setup/ceph-nautilus.md#kh%E1%BB%9Fi-t%E1%BA%A1o-osd)

### <a name="2" >2. Xoá OSD</a>

B1: báo với cụm ceph để ngưng hoạt động của ổ đĩa
`ceph osd out {osd-num}`
_Cần chờ 1 thời gian nhất định để cụm tái cân bằng. Sử dụng `ceph -w` để theo dõi._

B2: Giảm thiểu tối đa việc gây hỏng vật lý cho ổ đĩa, ta cần dừng việc hoạt động của ổ
 - `ssh <máy sở hữu ổ đĩa>`
 - `sudo systemctl stop ceph-osd@<id của ổ trong cụm>` vd: systemctl stop ceph-osd@4 

B3: Xoá ổ đĩa bằng phương pháp cũ
 - Xoá ổ đĩa bên trong crush map: `ceph osd crush remove <tên ổ đĩa>` VD: ceph osd crush remove osd.4
 - Xoá khoá xác thực của ổ đĩa trong cụm: `ceph auth del osd.{osd-num}` vd: ceph auth del osd.4
 - Xoá ổ đĩa khỏi cụm: `ceph osd rm {osd-num}` vd ceph osd rm 4

B4: Xoá ổ đĩa từ bản luminus trở lên
_Use ceph-deploy_

- Trước khi bị remove, osd thường ở trạng thái `up and in`, bạn cần phải take out nó ra khỏi cluser trước

`ceph osd out {osd-num}`

- Truy cập vào host và stop osd daemon cho osd đó

`sudo systemctl stop ceph-osd@{osd-num}`

- Remove osd (từ luminous trở lên)

`ceph osd purge {id} --yes-i-really-mean-it`

- Xóa trong file cấu hình nếu có

- Unmount LVM Volume group

`umount /var/lib/ceph/osd/ceph-{osd-num}`

- Xóa bỏ LVM Volume Group của OSD

`vgremove ceph-...`


Tham khảo [tại đây](https://docs.ceph.com/en/latest/rados/operations/add-or-rm-osds/#removing-osds-manual)
