# Mục lục
[I. Giới thiệu về Logical Volume Management (LVM)](#I.GT)
 - [1. Định nghĩa](#1.DinhNghia)
 - [2. Mô mình cơ bản của LVM](#2.MoHinh)

<a name="I.GT"></a>
# I. Giới thiệu về Logical Volume Management
<a name="1.DinhNghia"></a>
## 1. Định nghĩa 
LVM là kỹ thuật quản lý việc thay đổi kích thước lưu trữ của ổ cứng. Là một phương pháp ấn định không gian ổ đĩa thành những logical volume 
khiến cho việc thay đổi kích thước của một phân vùng trở nên dễ dàng. 
Điều này thật dễ dàng khi bạn muốn quản lý công việc của mình tại riêng một phân vùng mà muốn mở rộng nó ra lớn hơn hay 
thu hẹp phân vùng đó lại.

Tính năng này có trong nhân Linux từ năm 1999 và cho đến nay được hỗ trợ bởi tất cả các bản phân phối. Phương pháp cấu hình thiết bị này được 
sử dụng rộng rãi bởi các system admin cho các server, hệ thống NAT, SAN chạy bằng linux nhằm cải thiện tối đa hiệu quả khi sử dụng ổ đĩa.

LVM được sử dụng cho các mục đích sau:
 - Tạo 1 hoặc nhiều phần vùng logic hoặc phân vùng với toàn bộ đĩa cứng (hơi giống với RAID 0, nhưng tương tự như JBOD), cho phép thay đổi kích thước volume.
 - Quản lý trang trại đĩa cứng lớn (Large hard Disk Farms) bằng cách cho phép thêm và thay thế đĩa mà không bị ngừng hoạt động hoặc gián đoạn dịch vụ, kết hợp với trao đổi nóng (hot swapping).
 - Trên các hệ thống nhỏ (như máy tính để bàn), thay vì phải ước tính thời gian cài đặt, phân vùng có thể cần lớn đến mức nào, LVM cho phép các hệ thống tệp dễ dàng thay đổi kích thước khi cần.
 - Thực hiện sao lưu nhất quán bằng cách tạo snapshot nhanh các khối một cách hợp lý.
 - Mã hóa nhiều phân vùng vật lý bằng một mật khẩu.

<a name="2.MoHinh"></a>
# 2. Mô mình cơ bản của LVM

<img src="https://user-images.githubusercontent.com/79830542/170228577-b707b33a-403b-4291-a1f8-55075079b4d7.png" width="600">



[hình 1](https://www.brainupdaters.net/ca/brief-introduction-logical-volumes-lv-concept-example-application/)

[1. Các phân vùng](https://wikimaytinh.com/partition-la-gi-phan-vung-la-gi.html)
[What is /dev/sda in Linux?](https://www.tec4tric.com/linux/dev-sda-in-linux)
