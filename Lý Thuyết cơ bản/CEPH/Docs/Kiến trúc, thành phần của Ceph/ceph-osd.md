# OSD (Object Storage Device)
Đây là thành phần lưu trữ dữ liệu thực sự trên các thiết bị lưu trữ vật lý tại mỗi node dưới dạng các object. Phần lớn hoạt động bên trong Ceph Cluster được thực hiện bởi tiến trình Ceph OSD. Ceph OSD lưu tất cả dữ liệu người dùng dạng đối tượng. Ceph cluster bao gồm nhiều OSD.

Ceph OSD lưu tất cả client data dạng obj, đáp ứng yêu cầu yêu cầu đến data được lưu trữ. Ceph cluster bao gồm nhiều OSD. Trên mỗi hoạt động đọc và ghi, client request tới cluster maps từ monitors, sau đó, họ sẽ tương tác với OSDs với hoạt động đọc ghi, không có sự can thiệp monitors. Điều này kiến tiến trình xử lý dữ liệu nhanh hơn khi ghi tới OSD, lưu trữ data trực tiếp mà không thông qua các lớp xử lý data khác. Cơ chế `data-storage-and-retrieval mechanism` gần như độc nhất khi so sánh ceph với các công cụ khác.

Ceph nhân bản mỗi object nhiều lần trên tất cả các node, nâng cao tính sẵn sàng và khả năng chống chịu lỗi. Mỗi object trong OSD có một primary copy và nhiều secondary copy, được đặt tại các OSD khác. Bởi Ceph là hệ thống phân tán và object được phân tán trên nhiều OSD, mỗi OSD đóng vai trò là primary OSD cho một số object, và là secondary OSD cho các object khác. Khi một ổ đĩa bị lỗi, Ceph OSD daemon tương tác với các OSD khác để thực hiện việc khôi phục. Trong quá trình này, secondary OSD giữ bản copy được đưa lên thành primary, và một secondary object được tạo, tất cả đều xảy ra song song với quá trình sử dụng của người dùng. Điều này làm Ceph Cluster tin cậy và nhất quán. Thông thường, một OSD daemon đặt trên mọt ổ đĩa vật lý , tuy nhiên có thể đặt OSD daemon trên một host, hoặc 1 RAID. Ceph Cluster thường được triển khai trong môi trường JBOD, mỗi OSD daemon trên 1 ổ đĩa.

# 1. Ceph OSD File System
<p align="center">
  <img src="https://github.com/lacoski/tutorial-ceph/blob/master/images/ceph-osd.png" width="">
</p>

Ceph OSD gồm 1 ổ cứng vật lý, Linux filesystem trên nó, và sau đó là Ceph OSD Service. Linux filesystem của Ceph cần hỗ trợ extended attribute (XATTRs). Các thuộc tính của filesystem này cung cấp các thông tin về trạng thái object, metadata, snapshot và ACL cho Ceph OSD daemon, hỗ trợ việc quản lý dữ liêu. Ceph OSD hoạt động trên ổ đĩa vật lý có phân vùng Linux. Phân vùng Linux có thể là Btrfs, XFS hay Ext4. Sự khác nhau giữa các filesystem này như sau:

  - `Btrfs`: OSD chạy định dạng Btrfs, sẽ cung cấp hiệu năng tốt nhất khi so sánh với XFS, EXT4. Điểm mạnh khi sử dụng Btrfs là nó hỗ trợ các công nghệ mới nhất (copy-on-write, writable snapshots, vm provisioning, cloning v.v). Tuy nhiên Btrfs vẫn chưa ổn định trên một số nền tảng.
  - `XFS`: Đây là filesystem đã hoàn thiện và rất ổn định, và được khuyến nghị làm filesystem cho Ceph khi production. Tuy nhiên, XFS không thế so sánh về mặt tính năng với Btrfs. XFS có vấn đề về hiệu năng khi mở rộng metadata, và XFS là một journaling filesystem, có nghĩa, mỗi khi client gửi dữ liệu tới Ceph cluster, nó sẽ được ghi vào journal trước rồi sau đó mới tới XFS filesystem. Nó làm tăng khả năng overhead khi dữ liệu được ghi 2 lần, và làm XFS chậm hơn so với Btrfs, filesystem không dùng journal.
  - `Ext4`: Fourth Extended Filesystem - đây cũng là một filesystem dạng journaling và cũng có thể sử dụng cho Ceph khi production; tuy nhiên, nó không phôt biến bằng XFS. Ceph OSD sử dụng extended attribute của filesystem cho các thông tin của object và metadata. XATTRs cho phép lưu các thông tin liên quan tới object dưới dạng xattr_name và xattr_value, do vậy cho phép tagging object với nhiều thông tin metadata hơn. ext4 file system không cung cấp đủ dung lượng cho XATTRs do giới hạn về dung lượng bytes cho XATTRs. XFS có kích thước XATTRs lớn hơn.

# 2. Ceph OSD Journal

Có thể hiểu đơn giản Journal disk chính là phân vùng cached để lưu trữ dữ liệu, Tăng tốc độ ghi dữ liệu. Sau đó Ceph sẽ flush dần data này xuống lưu trữ dưới HDD

<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/184792709-11e53fd6-da65-4f3b-b310-0021df5e62ba.png" width="">
</p>

Ceph sử dụng journaling filesystems như Btrfs, XFS cho OSD. Trước khi đẩy dữ liệu tới backing store, Ceph ghi dữ liệu tới phân vùng đặc biệt gọi là “journal”. Nó là phân vùng đệm ảo tách biệt trên ổ đĩa quay hoặc trên phân vùng ổ SSD, hoặc là có thể là một file trên FS. Trong kỹ thuật, Ceph ghi tất cả tới jounal, sau đó mới lưu trữ tới backing storage.

Một dữ liệu ghi vào journal sẽ được lưu tại đây trong lúc syncs xuống backing store, mặc định là 5 giây chạy 1 lần. 10 GB là dung lượng phổ biến của journal, tuy nhiên journal càng lớn càng tốt. Ceph dùng journal để tăng tốc và đảm bảo tính nhất quán. Journal cho phép Ceph OSD thực hiện các tác vụ ghi nhỏ nhanh chóng; một tác vụ ghi ngẫu nhiên sẽ được ghi xuống journal theo kiểu tuần tự, sau đó được flush xuống filesystem. Điều này cho phép filesystem có thời gian để gộp các tác vụ ghi vào ổ đĩa. Hiệu năng sẽ tăng lên rõ rệt khi journal được tạo trên SSD.

Khuyến nghị, không nên vượt quá tỉ lệ 5 OSD / 1 journal đisk khi dùng SSD làm journal, vượt quá tỉ lệ này có thể gây nên thắt cổ chai trên cluster. Và khi SSD làm journal bị lỗi, toàn bộ các OSD có journal trên SSD đó sẽ bị lỗi. Với Btrfs, việc này sẽ không xảy ra, bởi Btrfs hỗ trợ copy-on-write, chỉ ghi xuống các dữ liệu thay đổi, mà không tác động vào dữ liệu cũ, khi journal bị lỗi, dữ liệu trên OSD vẫn tồn tại.

>Đối với hệ thống lưu trữ dữ liệu [BlueStore]() thì không còn sử dụng Journal disk

# 3. Ceph volume/Ceph disk

>Ở phiên bản từ 11.x khái niệm ceph-volume được xuất hiện thay thế dần và tiến tới thay thế hoàn toàn cho ceph-disk

Không nên sử dụng RAID cho Ceph Cluster:
  - Mặc định Ceph đã có khả năng nhân bản để bảo vệ dữ liệu, do đó không cần làm RAID với các dữ liệu đã được nhân bản đó. Với RAID group, nếu mất 1 ổ đĩa, việc phục hồi sẽ yêu cầu một ổ đĩa dự phòng, tiếp đó là chờ cho dữ liệu từ đĩa bị hỏng được ghi lên đĩa mới, do đó việc sử dụng RAID sẽ gây mất nhiều thời gian khi khôi phục cũng như giảm hiệu năng khi so với giải pháp lưu trữ phân tán. Tuy nhiên, nếu hệ thống có RAID controller, ta sẽ đặt mỗi ổ đĩa trong một RAID 0.
  - Phương pháp nhân bản dữ liệu của Ceph khong yêu câu một ổ cứng trống cùng dung lượng ổ hỏng. Nó dùng đường truyền mạng để khôi phục dữ liệu trên ổ cứng lỗi từ nhiều node khác. Trong quá trình khôi phục dữ liệu, dựa vào tỉ lệ nhân bản và số PGs, hầu như toàn bộ các node sẽ tham gia vào quá trình khôi phục, giúp quá trình này diễn ra nhanh hơn.
  - Sẽ có vấn đề về hiệu năng trên Ceph Cluster khi I/O ngẫu nhiên trên RAID 5 và 6 rất chậm.

# 4. Một vài lệnh cơ bản

Lệnh để kiểm tra tình trạng OSD trên 1 node:
```
service ceph status osd
```

Lệnh kiểm tra tình trạng OSD trên tất cả các node (lưu ý thông tin về tất cả OSD phải được khai báo trong `ceph.conf`):
```
service ceph -a status osd
```

Lệnh kiểm tra OSD ID:
```
ceph osd ls
```

Lệnh kiểm tra OSD map:
```
ceph osd stat
```

Lệnh kiểm tra OSD tree:
```
ceph osd tree
```
