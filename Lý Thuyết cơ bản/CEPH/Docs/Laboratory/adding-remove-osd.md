_**Các thao tác thực hiện dưới đây đều trên node admin**_

### <a name="1" >1. Thêm OSD</a>
Trong trường hợp đã biết ổ đĩa mới được thêm vào từ node nào.
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
 - Xoá ổ crush map: `ceph osd crush remove <tên ổ đĩa>` VD: ceph osd crush remove osd.4
 - Xoá khoá xác thực của ổ đĩa trong cụm: `ceph auth del osd.{osd-num}` vd: ceph auth del osd.4
 - Xoá ổ đĩa khỏi cụm: `ceph osd rm {osd-num}` vd ceph osd rm 4

Tham khảo [tại đây](https://docs.ceph.com/en/latest/rados/operations/add-or-rm-osds/#removing-osds-manual)
