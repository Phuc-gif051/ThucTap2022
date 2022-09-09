# Vị trí nhóm - Placement groups (PGs)


[Tổng quan](#1)

[Tính toán số PG cần thiết - Calculating PG numbers](#2)

[Quá trình khắc phục lỗi](#3)

---
## <a name="1" >Tổng quan</a>
Về cơ bản Ceph lưu trữ các data dưới dạng object trong các [pool](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/3/html/storage_strategies_guide/pools-1) - thiết bị lưu trữ ở mức logic.
> 1 pool có thể là 1 hay nhiều OSDs tạo thành (thường là nhiều OSDs 1 pool), hoặc cũng có trường hợp từ 1 OSD tạo thành nhiều pool.

Số lượng object lưu trữ trong các pool có thể lên đến hàng triệu hoặc hàng tỷ. Một hệ thống có hàng triệu object thì không thể theo dõi vị trí thực tế của từng đối tượng mà vẫn hoạt động trơn tru vì điều này rất tốn kém về mặt tính toán, đặc biệt là trên quy mô ngày càng lớn của mặt lưu trữ. 

Để có thể có hiệu suất lớn trên quy mô lớn, Ceph lại tiếp tục chia nhỏ các pool thành các [Placement groups (PG)](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/3/html/storage_strategies_guide/placement_groups_pgs), và chỉ định từng object riêng lẻ cho từng PG nhất định, chỉ định từng PG riêng lẻ cho 1 [OSD](ceph-osd.md) nhất định. Khi xảy ra trường hợp OSD bị lỗi hay cụm cần cân bằng lại, thay vì phải thao tác với từng object riêng lẻ thì Ceph thao tác với các PG. Tức là Ceph có thể sao chép hay di chuyển toàn bộ các PG cùng với các object bên trong các PG đó.

<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/187576791-b3ea251e-2be9-4d2b-8297-8fe568be077b.png" width="700">
</p>

Chịu trách nhiệm cho việc chỉ định ở trên là [CRUSH](https://docs.ceph.com/en/quincy/rados/operations/crush-map/). Khi chỉ định PG cho OSD, CRUSH sẽ tính toán hàng tất cả các OSD - bắt đầu bằng OSD lưu trữ bản gốc (primary). Khi xác định được OSD lưu bản gốc, CRUSH sẽ tiếp tục xác định các OSD phụ lưu bản sao (secondary) để sao chép các PG. 
>Ví dụ: bạn có 5 OSDs, CRUSH tự tính toán và chỉ định 1 lượng object nhất định cho PG 5 và PG 5 được chỉ định lưu trữ tại OSD 3, từ đó OSD 3 trở thành primary của PG 5. Sau đó nếu CRUSH tính toán và xác định được OSD 1 và 5 sẽ làm nơi lưu bản sao cho PG 5 thì OSD 3 sẽ sao chép dữ liệu của PG 5 sang OSD 1 và 5.

Ceph hoàn toàn tự động thực hiện các công việc trên, điều đó làm đơn giản hơn cho giao diện và các công việc của khách hàng. Quá trình tương tự khi Ceph tự phục hồi và cân bằng lại.

<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/187582878-92b1db7c-5c8c-48c1-ac5d-d74780ffe24b.png" width="">
</p>

Khi OSD primary bị lỗi mà được đánh dấu ra khỏi cụm. CRUSH sẽ chỉ định các PG bên trong nó cho một OSD khác. OSD thay thế sẽ nhận các bản sao PG từ các OSD secondary. 1 trong các OSD này sẽ trở thành OSD primary.

Khi ta có thay đổi về số bản sao thì CRUSH cũng sẽ tự động thay đổi thay đổi các PG và các OSD theo yêu cầu.

##	<a name="2" >Tính toán số PG cần thiết - Calculating PG numbers</a>

Số lượng PGs trong cluster cần được tính toán tỉ mỉ. Thông thường, tăng số lượng PGs trong cluster sẽ giảm bớt gánh nặng trên mỗi OSD, nhưng cần xem xét theo quy chuẩn. Khuyến nghị 50-100 PGs trên mỗi OSD. Nó tránh tiêu tốn quá nhiều tài nguyên trên mỗi OSD node, giảm gánh nặng OSD. Khi dữ liệu tăng, ta cần mở rộng cluster cùng với điều chỉnh số lượng PGs. Khi thiếtt bị mới được thêm, xóa bỏ khỏi cluster, các PGs sẽ vẫn tồn tại – CRUSH sẽ quản lý việc tài cấp phát PGs trên toàn cluster.

`
Giái trị PGP là tổng số PGs cho mục đích tổ chức dữ liệu, giá trị này cần bằng PGs
`

Xác định tổng số PGs là bước cần thiết khi xây dựng hạ tầng Ceph storage cluster cho doanh nghiệp. PGs sẽ quyết đinh hiệu năng storge. Công thức tính tổng placement group cho Ceph cluster:

`
Total PGs = (Total_number_of_OSD * 100) / pool size

Thường thì pool size chính là số bản nhân bản của 1 pool (đa phần mặc định là 3 hoặc tuỳ vào hệ thống do người quản trị đặt)

Kết quả làm tròn lên đến luỹ thừa gần nhất của 2.
`



>VD1: 1 Cluster bao gồm 200 OSD, số bản nhân bản của pool là 3. => Tổng PGs = (200*100)/3 = 6667 (2^12 < 6667 < 2^13); làm tròn đến luỹ thừa gần nhất của 2 là 8192 = 2^13


Tính số PGs trên từng OSDs, thường thì chỗ này Ceph sẽ tự tính với công thức (tổng số PGs * pool size)/tổng số OSD

>VD2: Cluster có 20 OSDs với 512 PGs, mức nhân bản 3
CRUSH gán mỗi PG 3 OSDs
Kết thúc, (512*3)/20 = (70 -> 100) PGs
Mỗi 1 OSD lỗi => 19 OSD sẽ backup lại dữ liêu => OSD lỗi = 1 TB => 10 OSD giữa 100GB (đủ 1 TB OSD lỗi) => càng nhiều OSD tốc độ backup càng cao.

>VD3: Cluster 40 OSD, 512 PGs, 3 repical pool
Crush gán 3 OSD mỗi PG
Sau tính toán, mỗi OSD chứa (512*3)/40 = 30 -> 45 PGs => 1 OSD lỗi (1TB data) => 39 OSD còn lại sẽ backup => Dung lượng Backup mỗi OSD = 1000 / 39 ~ 25 GB mỗi OSD => Quá trình backup diễn ra càng nhanh khi có nhiều OSD

>VD4: 200 OSD, 512 PGs, 3 repi pool
CRUSH gán mỗi PG 3 OSD
Sau tính toán, mỗi OSD chứa 6-8 PGs
Khi 1 OSD lỗi, 7*3 OSD sẽ diễn ra hoạt động backup => Dung lượng backup trên 21 OSD = 1000/21 ~~ 47 GB (nhanh hơn so với 10 PG)

Chọn lựa số PGs:
- Nhỏ hơn 5 OSD => set pg_num = 128
- 5-10 OSD => set pg_num = 512
- 10-50 OSD => set pg_num = 4096

Command tùy chỉnh:
`
ceph osd pool set {pool-name} pg_num
`

`
VD: cluster bao gồm 160 OSD, 3 repli
=> total PGs = (OSD * 100)/3 = (160*100)/3 = 5333.333 => làm tròn 8192 (2^13 > 5333)
`

## <a name="3" >Quá trình khắc phục lỗi:</a>
1. Khi OSD lỗi, tất cả dữ liệu trên OSD bị mất, mức nhân bản PG từ 3 về 2
2. Ceph thực hiện quá trình khôi phục, PG sẽ được OSD mới, thực hiện quá trình đưa bản sao của PG từ các OSD còn lại vào.
3. Trường hợp xấu, OSD sao lưu của PGs cũng chết (chết 2/3) trước khi OSD mới được đừa vào cụm => Dữ liệu nguy hiểm (chỉ còn 1 bản backup)
4. Ceph tiếp tục chọn OSD khác, đưa bản sao của PG vào, bảo đảm mức nhân bản
5. Khi OSD (3/3) chết trong cùng PG trước khi quá trình backup diễn ra => dữ liệu mất vĩnh viễn


## Tham khảo tại
1. [Chapter 3. Placement Groups (PGs)](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/3/html/storage_strategies_guide/placement_groups_pgs#pg_count)
2. [Vị trí nhóm - Placement groups](https://github.com/lacoski/khoa-luan/blob/master/Ceph/ceph-inside.md#v%E1%BB%8B-tr%C3%AD-nh%C3%B3m---placement-groups)

Date acced: 31/08/2022
