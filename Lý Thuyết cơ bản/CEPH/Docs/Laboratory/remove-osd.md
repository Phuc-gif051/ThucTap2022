B1: báo với cụm ceph để ngưng hoạt động của ổ đĩa
`ceph osd out {osd-num}`
_Cần chờ 1 thời gian nhất định để cụm tái cân bằng. Sử dụng `ceph -w` để theo dõi._

B2: Giảm thiểu tối đa việc gây hỏng vật lý cho ổ đĩa, ta cần dừng việc hoạt động của ổ
 - `ssh <máy sở hữu ổ đĩa>`
 - `sudo systemctl stop ceph-osd@<id của ổ trong cụm>` 

b3: Xoá ổ đĩa bằng phương pháp cũ
 - Xoá ổ crush map: `ceph osd crush remove <tên ổ đĩa>`. VD: ceph osd crush remove osd.5
 - Xoá khoá xác thực của ổ đĩa trong cụm: `ceph auth del osd.{osd-num}` vd: ceph auth del osd.5
 - Xoá ổ đĩa khỏi cụm: `ceph osd rm {osd-num}` vd ceph osd rm 1
