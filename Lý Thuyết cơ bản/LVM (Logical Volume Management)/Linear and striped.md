# Mục lục
[I. Cơ chế ghi đĩa của LVM 📖](#I)
 - [1. Linear](#I.1)
 - [2. Striped](#I.2)


[II. Thực hành (Lab) 🖥️](#II)
 - [1. Chuẩn bị](#II.1)
 - [2. Thực hành](#II.2)

[III. Tài liệu tham khảo 📚](#III)
___
# <a name="I">I. Cơ chế ghi đĩa của LVM 📖</a>
Ở bài trước chúng ta đã cùng nhau tìm hiểu về công nghệ LVM là như thế nào. Vậy LVM sẽ lưu trữ dữ liệu ra sao và 
kiểu lưu dữ liệu nào sẽ là tối ưu. Ở bài này ta sẽ tìm hiểu về hai kiểu lưu trữ trong LVM là linear và striped.


## <a name="I.1">1. Linear </a>

<img src="https://github.com/hocchudong/thuctap012017/blob/master/TVBO/docs/LVM/pictures/linear-read-write-pattern.gif" width="600">

Như trên hình minh hoạ, ta cũng có thể hiểu đơn giản là cơ chế này sẽ lưu trữ tuần tự vào từng phân vùng. Nó không quan tâm hệ thống có bao 
nhiêu phân vùng, khi lưu trữ hết phân vùng này nó sẽ chuyển sang phân vùng khác để lưu trữ tiếp. Tại 1 thời điểm thì chỉ có 1 phân vùng (1 ổ đĩa) hoạt động.

 - Ưu điểm: dữ liệu được tập chung, dễ dàng quản lý.
 - Nhược điểm: hiệu suất thấp, tại 1 thời điểm thì chỉ có 1 phân vùng (1 ổ đĩa) được hoạt động, gây lãng phí tài nguyên.

## <a name="I.2"> 2. Striped </a>

<img src="https://github.com/hocchudong/thuctap012017/blob/master/TVBO/docs/LVM/pictures/striped-read-write-pattern.gif" width="600">

Còn với striped, nó sẽ quan tâm đến việc nó được làm việc với bao nhiêu phân vùng. Cơ chế hoạt động của nó cơ bản là giống với RAID 0. 
Nó sẽ chia nhỏ dữ liệu ra, rồi ghi những phần chia nhỏ đó vào từng phân vùng mà nó sở hữu.

 - Ưu điểm: hiệu suất cao, tại 1 thời điểm thì các phân vùng đều được hoạt động, tránh lãng phí tài nguyên.
 - Nhược điểm: nguy cơ cao bị tổn hại về dữ liệu nếu không may 1 phân vùng bị hư hại.

# <a name="II">II. Thực hành 🖥️</a>

## <a name="II.1">1. Chuẩn bị</a>
 - Cần ít nhất 3 phân vùng (ổ đĩa) để thực hành được tốt nhất
 - Cài đặt công cụ `bwm-ng` để giám sát quá trình đọc ghi của từng phân vùng (ổ đĩa)
 - Tiến hành cấu hình LVM như [bài trước](https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/LVM%20(Logical%20Volume%20Management)/what%20is%20LVM.md#2-th%E1%BB%B1c-h%C3%A0nh-tr%C3%AAn-centos-7)
các bước cơ bản là:

    + Bước 1: Tạo ra Physical Volumes từ không gian của một hay nhiều đĩa cứng.

    + Bước 2: Tạo ra Volume Groups từ không gian của các Physical Volume.

    + Bước 3: Tạo ra Logical Volume từ Volume Groups.
    
    + Bước 4: định dạng lại Logical Volume ở dạng mà hệ thống Centos có thể sử dụng được (định dạng như ext (2,3,4) hay xfs,.v.v).
    
    + Bước 5: Tạo điểm mount và tiến hành mount Logical Volume vào hệ thống.
    
## <a name="II.2">2. Thực hành</a>
Trên môi trường lab hiện có 6 ổ cứng, 1 ổ đã dùng để cài OS nên ta sẽ không can thiệp vào. Ta sẽ thành trên 5 ổ còn lại, hiện tại đang không
lưu trữ dữ liệu có thể tự do can thiệp.

<img src="https://user-images.githubusercontent.com/79830542/171358102-e0f17684-1629-45c2-919e-587b52acd061.png" width="600">

Sau đó tiến hành cấu hình LVM như đã chuẩn bị ở trên.

♨️ TH1: Với `Linear`

Ta có 1 lv (logical volume) với dung lượng khoảng 50G, nằm trên ổ /dev/sda được mount vào hệ thống với Mount point là /vdisk.
Sử dụng `fio` để tiến hành test với câu lệnh `fio --randrepeat=0 --ioengine=libaio --name=lv_linear --filename=lv_linear --bs=62k --iodepth=64 --size=5G --readwrite=randrw --rwmixread=25`

Sử dụng `bwm-ng -i disk` để giám sát việc IO của ổ cứng.

<img src="https://user-images.githubusercontent.com/79830542/171361671-07bd3a87-6463-4e01-aa57-5d6f55b452e7.png" width="600">

Có thể thấy với `linear` thì chỉ duy nhất ổ cứng đầu tiên (ổ sda) được hoạt động cho việc đọc ghi.

♨️ TH2: Với `Striped`

Đầu tiên ta cần cấu hình `striped` cho lvm biết. Vẫn sử dụng câu lệnh lvcreate với 1 số tham số đặc biệt `lvcreate -L Z -n X -i N Y`

Trong đó: 
 - Z: dung lượng lv (logical volume) mà ta muốn tạo
 - X: tên của lv
 - N: số lượng ổ cứng mà ta muốn áp dụng striped (hệ thống sẽ lấy theo tứ tự từ trên xuống, 1 cách lần lượt)
 - Y: tên của vg (volume group) mà chứa lv muốn tạo

Trong bài này có 5 ổ sẵn sàng, ta sẽ sử dụng cả 5 ổ. 

<img src="https://user-images.githubusercontent.com/79830542/171365536-6b74e067-1087-42b7-bc81-69717473a359.png" width="600">

Sử dụng `lvdisplay X -m` để kiểm tra thông tin của lv mà ta vừa tạo. Trong đó `X` là đường dẫn tới lv mà ta muốn xem thông tin theo định dạng
`vg_name/lv_name`

<img src="https://user-images.githubusercontent.com/79830542/171368696-d2e94f0f-fd28-4c2d-ac8b-d4854b2fb3a3.png" width="600">

Chú ý tại phần được tô vàng các thông số như `type`, `stripesq`,`stripe size` đã đúng với yêu cầu của ta đặt ra hay chưa.

Để tiến hành test ta vẫn sử dụng câu lệnh `fio --randrepeat=0 --ioengine=libaio --name=lv_striped --filename=lv_striped --bs=64k --iodepth=64 --size=5G --readwrite=randrw --rwmixread=25
`

Và sử dụng `bwm-ng -i disk` để giám sát IO của ổ đĩa.

<img src="https://user-images.githubusercontent.com/79830542/171370829-c16c52b3-add4-4570-835b-3ebce402262b.png" width="600">

Có thể thấy khi cấu hình `striped` cho 5 ổ đĩa thì cả 5 đều hoạt động cùng lúc, tăng hiệu năng lên rất nhiều so với `linear`

# <a name="III">III. Tài liệu tham khảo 📚</a>
[1. Cơ chế ghi đĩa Striping - LVM Stripe](https://github.com/hocchudong/thuctap012017/blob/master/TVBO/docs/LVM/docs/lvm-stripping.md)

[2. lvm-linear-striped](https://blog.cloud365.vn/linux%20tutorial/lvm-linear-striped/#thuc-hien)
