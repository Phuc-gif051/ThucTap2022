# Vị trí nhóm - Placement groups (PGs)
---
## Tổng quan
Khi Ceph cluster nhận yêu cầu lưu trữ data, nó sẽ lưu trữ các data dưới dạng object và chia object vào các nhóm, các nhóm này được gọi là placement groups (PG). [CRUSH](https://docs.ceph.com/en/latest/rados/operations/crush-map/) sẽ tổ chức dữ liệu thành tập các Object, dựa trên hàm hash (hàm băm) và id object, mức nhân bản, các PGs (placement groups) trong hệ thông sẽ có các PGs ID tương ứng. Placement groups được coi là tập logical (logical collection) các object được nhân bản trên các OSDs khác nhau, qua đó nâng cao tính bảo đảm dữ liệu, tính sẵn sàng cao (HA) tại Ceph storage system. 

Dựa trên mức replicate của Ceph pool, placement group sẽ được nhân bản, phân tán trên nhiều hơn 1 OSD tại Ceph cluster. Ta có thể cân nhắc placement group như logical container chứa các object. PGs (vị trí nhóm) được thiết kế đáp ứng khả năng mở rộng, hiệu suất cao trong Ceph storage system, đồng thời hỗ trợ việc quản trị Object.

<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/184801375-77cd9888-4e91-4292-be87-8884a0fdcd2d.png" width="500">
</p>

Nếu không có các PGs, việc quản trị dữ liệu sẽ trở nên rất khó, cùng với đó là khả tổ chức các object đã được nhân bản (hảng triệu object) tới hàng trăm các OSD khác nhau. Qua đó, thay vì quản trị object riêng biệt, hệ thông sẽ sử dụng PGs (chứ số lượng rất nhiều object). PGs sẽ khiến ceph dễ quản trị dữ liệu và giảm bớt sự phức tạp trong khâu quản lý. Mỗi PG sẽ yêu cầu tài nguyên hệ thống nhất đinh (CPU và Memory,... vì chúng quản lý rất nhiều object).

Số lượng PGs trong cluster cần được tính toán tỉ mỉ. Thông thường, tăng số lượng PGs trong cluster sẽ giảm bớt gánh nặng trên mỗi OSD, nhưng cần xem xét theo quy chuẩn. Khuyến nghị 50-100 PGs trên mỗi OSD. Nó tránh tiêu tốn quá nhiều tài nguyên trên mỗi OSD node, giảm gánh nặng OSD. Khi dữ liệu tăng, ta cần mở rộng cluster cùng với điều chỉnh số lượng PGs. Khi thiếtt bị mới được thêm, xóa bỏ khỏi cluster, các PGs sẽ vẫn tồn tại – CRUSH sẽ quản lý việc tài cấp phát PGs trên toàn cluster.

```
Giái trị PGP là tổng số PGs cho mục đích tổ chức dữ liệu, giá trị này cần bằng PGs
```

##	Tính toán số PG cần thiết - Calculating PG numbers
Xác định tổng số PGs là bước cần thiết khi xây dựng hạ tầng Ceph storage cluster cho doanh nghiệp. PGs sẽ quyết đinh hiệu năng storge. Công thức tính tổng placement group cho Ceph cluster:
```
Total PGs = (Total_number_of_OSD * 100) / pool size

Thường thì pool size chính là số bản nhân bản của 1 pool (đa phần mặc định là 3 hoặc tuỳ vào hệ thống do người quản trị đặt)

Kết quả làm tròn lên đến luỹ thừa gần nhất của 2.
```


```
VD1: 1 Cluster bao gồm 200 OSD, số bản nhân bản của pool là 3. => Tổng PGs = (200*100)/3 = 6667 (2^12 < 6667 < 2^13); làm tròn đến luỹ thừa gần nhất của 2 là 8192 = 2^13
```

Tính số PGs trên từng OSDs, thường thì chỗ này Ceph sẽ tự tính với công thức (tổng số PGs * pool size)/tổng số OSD
```
VD2: Cluster có 20 OSDs với 512 PGs, mức nhân bản 3
CRUSH gán mỗi PG 3 OSDs
Kết thúc, (512*3)/20 = (70 -> 100) PGs
Mỗi 1 OSD lỗi => 19 OSD sẽ backup lại dữ liêu => OSD lỗi = 1 TB => 10 OSD giữa 100GB (đủ 1 TB OSD lỗi) => càng nhiều OSD tốc độ backup càng cao.

VD3: Cluster 40 OSD, 512 PGs, 3 repical pool
Crush gán 3 OSD mỗi PG
Sau tính toán, mỗi OSD chứa (512*3)/40 = 30 -> 45 PGs => 1 OSD lỗi (1TB data) => 39 OSD còn lại sẽ backup => Dung lượng Backup mỗi OSD = 1000 / 39 ~ 25 GB mỗi OSD => Quá trình backup diễn ra càng nhanh khi có nhiều OSD

VD4: 200 OSD, 512 PGs, 3 repi pool
CRUSH gán mỗi PG 3 OSD
Sau tính toán, mỗi OSD chứa 6-8 PGs
Khi 1 OSD lỗi, 7*3 OSD sẽ diễn ra hoạt động backup => Dung lượng backup trên 21 OSD = 1000/21 ~~ 47 GB (nhanh hơn so với 10 PG)
```
Chọn lựa số PGs:
- Nhỏ hơn 5 OSD => set pg_num = 128
- 5-10 OSD => set pg_num = 512
- 10-50 OSD => set pg_num = 4096

Command tùy chỉnh:
```
ceph osd pool set {pool-name} pg_num
```

```
VD: cluster bao gồm 160 OSD, 3 repli
=> total PGs = (OSD * 100)/3 = (160*100)/3 = 5333.333 => làm tròn 8192 (2^13 > 5333)
```

## Quá trình khắc phục lỗi:
1. Khi OSD lỗi, tất cả bản sao trên OSD bị mất, mức nhân bản PG từ 3-2
2. Ceph thực hiện quá trình khôi phục, PG sẽ chọn OSD mới, đưa vào PGs, thực hiện quá trình nhân bản
3. Trường hợp xấu, OSD thứ trong PGs chết (chết 2/3) trước khi OSD được đừa vào cụm => Dữ liệu nguy hiểm (chỉ còn 1 bản backup)
4. Ceph tiếp tục chọn OSD khác, đưa vào PG, bảo đảm mức nhân bản
5. Khi OSD (3/3) chết trong cùng PG trước khi quá trình backup diễn ra => dữ liệu mất vĩnh viễn


## Tham khảo tại
1. [Chapter 3. Placement Groups (PGs)](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/3/html/storage_strategies_guide/placement_groups_pgs#pg_count)
2. [Vị trí nhóm - Placement groups](https://github.com/lacoski/khoa-luan/blob/master/Ceph/ceph-inside.md#v%E1%BB%8B-tr%C3%AD-nh%C3%B3m---placement-groups)
