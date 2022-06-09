# Mục lục
[I. Giới thiệu về Logical Volume Management (LVM) 📖](#I.GT)
 - [1. Định nghĩa](#1.DinhNghia)
 - [2. Mô mình cơ bản của LVM](#2.MoHinh)
 - [3. Các ưu nhược điểm khi sử dụng LVM](#3.dis-advantage)

[II. Thực hành với LVM (lab) 🖥️](#II.Lab)
 - [1. Lý thuyết cần biết](#1.LyThuyet)
 - [2. Thực hành trên Centos 7](#2.lab)

[III. Tài liệu tham khảo 📚](#III.references)

<a name="I.GT"></a>
# I. Giới thiệu về Logical Volume Management 📖
<a name="1.DinhNghia"></a>
## 1. Định nghĩa 
LVM là kỹ thuật quản lý việc thay đổi kích thước lưu trữ của ổ cứng. Là một phương pháp ấn định không gian ổ đĩa thành những logical volume 
khiến cho việc thay đổi kích thước của một phân vùng trở nên dễ dàng. 
Điều này thật dễ dàng khi bạn muốn quản lý công việc của mình tại riêng một phân vùng mà muốn mở rộng nó ra lớn hơn hay 
thu hẹp phân vùng đó lại.

Tính năng này có trong nhân Linux từ năm 1999 và cho đến nay được hỗ trợ bởi tất cả các bản phân phối. Phương pháp cấu hình thiết bị này được 
sử dụng rộng rãi bởi các system admin cho các server, hệ thống NAS (Network Attached Storage), SAN (Storage Area Networking) chạy bằng linux nhằm cải thiện tối đa hiệu quả khi sử dụng ổ đĩa.

LVM được sử dụng cho các mục đích sau:
 - Tạo 1 hoặc nhiều phần vùng logic hoặc phân vùng với toàn bộ đĩa cứng (hơi giống với RAID 0, nhưng tương tự như JBOD), cho phép thay đổi kích thước volume.
 - Quản lý trang trại đĩa cứng lớn (Large hard Disk Farms) bằng cách cho phép thêm và thay thế đĩa mà không bị ngừng hoạt động hoặc gián đoạn dịch vụ, kết hợp với trao đổi nóng (hot swapping).
 - Trên các hệ thống nhỏ (như máy tính để bàn), thay vì phải ước tính thời gian cài đặt, phân vùng có thể cần lớn đến mức nào, LVM cho phép các hệ thống tệp dễ dàng thay đổi kích thước khi cần.
 - Thực hiện sao lưu nhất quán bằng cách tạo [snapshot](https://github.com/hocchudong/thuctap012017/blob/master/TVBO/docs/LVM/docs/lvm-snapshot.md) một cách hợp lý.
 - Mã hóa nhiều phân vùng vật lý bằng một mật khẩu.

<a name="2.MoHinh"></a>
# 2. Mô mình cơ bản của LVM

<img src="https://user-images.githubusercontent.com/79830542/170228577-b707b33a-403b-4291-a1f8-55075079b4d7.png" width="600">

[hình 1](https://www.brainupdaters.net/ca/brief-introduction-logical-volumes-lv-concept-example-application/)

 - Hard drives: các đĩa cứng vật lý
 - Partition: các phân vùng cơ bản của ổ cứng vật lý
 - Physical volume: LVM gọi cả hard drives và các Partition là Physical volume, 1 physical volume có thể là 1 hoặc nhiều đĩa cứng, là 1 hoặc nhiều phân vùng của 1 hoặc nhiều đĩa cứng.
 - Volume group: là 1 nhóm các physical volume, LVM sẽ gom nhóm những Physical volume được chỉ định thành 1 group, hay được coi là 1 ổ đĩa ảo.
 - Logical volume: các phân vùng của volume group, hay còn được gọi là các phân ảo của ổ đĩa ảo. Nó sẽ được format cho phù hợp với yêu cầu của người dùng.
 - File system: Hệ thống tập tin quản lý các file và thư mục trên ổ đĩa, được mount tới các Logical Volume trong mô hình LVM 

<a name="3.dis-advantage"></a>
## 3. Các ưu nhược điểm khi sử dụng LVM
### 3.1 Ưu điểm
 - Có thể tạo ra các vùng dung lượng lớn nhỏ tuỳ ý. Quản lý bộ nhớ 1 cách hiệu quả nhất.
 - Có thể kế hợp hot swap (trao đổi, thay thế, sửa chữa không cần tắt máy) Không để hệ thống bị gián đoạn hoạt động.
### 3.2 Nhược điểm
 - Càng gắn nhiều đĩa cứng và thiết lập càng nhiều LVM thì hệ thống khởi động càng lâu.
 - Khả năng mất dữ liệu cao khi một trong số các đĩa cứng bị hỏng. (nên thiết lập [raid soft]())
 - Windows không thể nhận ra vùng dữ liệu của LVM. Nếu Dual-boot ,Windows sẽ không thể truy cập dữ liệu trong LVM. (đối với người dùng cá nhân thì đây là điều khá bất tiện khi muốn sử dụng song song cả 2 OS-Operating System.)


<a name="II.Lab"></a>
# II. Thực hành với LVM (lab) 🖥️
_Chú ý: Nếu phân vùng được mount vào thư mục /root rồi thì không thể tạo physical volume. Muốn thao tác được tới các phân vùng trước tiên ta phải umount tất cả các phân vùng hay các logical mà ta muốn tác động đến._

<a name="1.LyThuyet"></a>
## 1. Lý thuyết cần biết
 - Sử dụng câu lệnh `lvm help` để xem chi tiết nhất, dưới đây là tóm lược các chức năng chính của LVM
 - Đối với các thao tác về Physical Volumes. Ta sẽ sử dụng các câu lệnh chứa tiền tố `pv*` được hỗ trợ trong terminal của Linux. Chúng bao gồm:

            pvchange   pvck       pvcreate   pvdisplay  pvmove     

            pvremove   pvresize   pvs        pvscan

 - Đối với những các thao tác về Volume Group. Ta sẽ sử dụng các câu lệnh chứa tiền tố `vg*` được hỗ trợ trong terminal. Chúng bao gồm:

            vgcfgbackup    vgck           vgdisplay      vgimport       vgmknodes      vgrename       vgsplit

            vgcfgrestore   vgconvert      vgexport       vgimportclone  vgreduce       vgs

            vgchange       vgcreate       vgextend       vgmerge        vgremove       vgscan
            
  - Đối với các thao tác về Logical Volume. Ta sẽ sử dụng các câu lệnh có tiền tố `lv*` hỗ trợ trong termial. Chúng bao gồm:

            lvchange     lvdisplay    lvmchange    lvmdiskscan  lvmpolld     lvreduce     lvresize

            lvconvert    lvextend     lvmconf      lvmdump      lvmsadc      lvremove     lvs

            lvcreate     lvm          lvmconfig    lvmetad      lvmsar       lvrename     lvscan
    đây chính là những volume hoàn chỉnh ở mức cuối cùng trước khi có thể mount vào hệ điều hành. Ta có thể thay đổi, thêm bớt kích thước của những volume một cách nhanh chóng. 
    
Tóm lại, LVM có thể sử dụng các chức năng trên để kết hợp các Physical Volume vào trong một Volume Group tạo ra 1 sự thống nhất không gian lưu trữ có sẵn trên hệ thống. Sau đó, ta có thể chia chúng thành những phân vùng có kích thước khác nhau theo mong muốn của người dùng.

Các bước để sử dụng LVM cho việc quản lý ổ đĩa như sau:

        + Bước 1: Tạo ra Physical Volumes từ không gian của một hay nhiều đĩa cứng.

        + Bước 2: Tạo ra Volume Groups từ không gian của các Physical Volume.

        + Bước 3: Tạo ra Logical Volume từ Volume Groups và sử dụng chúng.
        
<a name="2.lab"></a>        
## 2. Thực hành trên Centos 7     
👓 Sử dụng câu lệnh `lvmdiskscan` để xem ta có thể thao tác được với bao nhiêu phần của bộ nhớ.
<img src="https://user-images.githubusercontent.com/79830542/170408904-2631fa93-1a38-40a4-858e-d00d6bd63614.png" width=600>

Như trên hình thì ta có thể thao được với 4 phân vùng, trong đó có 1 phân vùng đã được LVM quản lý, phân vùng sdc1 thì quá nhỏ so với 2 phân vùng còn lại nên ta sẽ bỏ qua, tiến hành lab với 2 phân vùng còn lại.

<img src="https://user-images.githubusercontent.com/79830542/170409750-fb18aae7-afa5-4b7f-8eda-55c6b45e25c6.png" width="500">

👓 Như chú ý ở trên, 2 phân vùng đã được mount vào thư mục /test1 và /test2 nên ta không thể tiến hành pvcreate (physical volume create) được. Ta tiến hành unmount bằng lệnh `umount /dev/sda1 /dev/sdb1`

Unmount thành công ta sử dụng lệnh `pvcreate` để tạo 1 physical volume mới, nếu hiện yêu cầu wipe như hình dưới thì nên chọn Y để hệ thống hoạt động tốt nhất.

<img src="https://user-images.githubusercontent.com/79830542/170410164-078cd100-3e17-4930-8847-9ae81455bab2.png" width="500">

Create thành công, LVM đã được quyền quản lý 2 phân vùng sda1 và sdb1.

👓 Sau khi tạo thành công physical volume, ta tiến hành tạo Volume group (nhóm các physical volume thành 1 ổ đĩa ảo để quản lý). Nếu như có nhiều Physical volume thì ta có thể chia thành nhiều Volume group hoặc gộp tất cả thành 1 group duy nhất. Sử dụng câu lệnh `vgcreate VirtualDisk /dev/sda1 /dev/sdb1`. Trong đó:
 - VirtualDisk là tên của Volume group mà ta muốn tạo
 - /dev/sda1 /dev/sdb1 là các Physical volume mà ta muốn gom thành 1 nhóm.
<img src="https://user-images.githubusercontent.com/79830542/170411569-f3e08797-b6fc-4330-b990-3446ce3223b0.png" width="500">

Tạo thành công Volume group, để kiểm tra chính xác, ta dùng lệnh `pvs` để xem.

<img src="https://user-images.githubusercontent.com/79830542/170411756-6ed3d93f-8028-4d66-84f5-58ed718c172d.png" width="500">

Hoặc trực quan hơn với lệnh `vgs`

<img src="https://user-images.githubusercontent.com/79830542/170412337-23684a5c-4d70-4ba8-ab5a-305723709815.png" width=500>

👓 Khi đã có Volume group ta đã có thể tiến hành, tạo và mount các Logical volume để có thể cho hệ thống sử dụng. Mình sẽ tạo ra các Logical volume với thông số và dung lượng như sau:
 - Test1: 10 GiB
 - Test2: 20 GiB
 - Test3: 15 GiB

Sử dụng câu lệnh `lvcreate -L X -n N V`, trong đó:
 - X: dung lượng của Logical volume (10, 20, 15 GiB)
 - N: tên (test1 test2 test 3)
 - V: tên của Volume group
Tạo thành công, sử dụng lệnh `lvs` để kiểm tra lại xem có đúng với yêu cầu hay không.
<img src="https://user-images.githubusercontent.com/79830542/170413746-c6b93787-aaec-40c6-bc27-274dc3475edc.png" width="500">

👓 Đã có Logical volume, muốn sử dụng nó ta cần phải định dạng lại Logical volume (format) và tạo MountPoint để hệ thống có thể tiếp nhận và sử dụng bình thường. 

Đầu tiên, tiến hành format 3 phân vùng đã tạo ở trên. Nhưng, ta cần phải lưu ý rằng, các Logical Volume có thể được truy cập ở hai nơi đó là:

                    /dev/volume_group_name/logical_volume_name

                và

                    /dev/mapper/volume_group_name-logical_volume_name

                vì vậy, khi format ta có thể sử dụng câu lệnh sau (mình sẽ sử dụng theo định dạng ext4 ):

                    mkfs.ext4 /dev/VirtualDisk/test1
                    mkfs.ext4 /dev/VirtualDisk/test2
                    mkfs.ext4 /dev/VirtualDisk/test3

                hoặc

                    mkfs.ext4 /dev/mapper/VirtualDisk-test1
                    mkfs.ext4 /dev/mapper/VirtualDisk-test2
                    mkfs.ext4 /dev/mapper/VirtualDisk-test3
<img src="https://user-images.githubusercontent.com/79830542/170416267-ef85117a-4f9c-4430-bfee-22e029e30f60.png" width="500">

Format thành công, ta tiến hành mount. Đầu tiên tạo mount point, dùng lệnh `mkdir tên_thư_mujc` để tạo 1 thư mục làm điểm mount. Sau khi có thư mục, dùng lệnh `mount /dev/điểm_cần_mount /dev/vị_trí_mount`

Kiểm tra xem đã mount thành công hay chưa ta sử dụng `df -h` hoặc `lsblk`, nếu mount thành công sẽ hiện MOUNTPOINT là thư mục mà mình chỉ định.

<img src="https://user-images.githubusercontent.com/79830542/170432836-fd6344fb-104b-43b6-9d3d-af0135b99a5b.png" width="500">

Như vậy coi như là đã thành công, nếu muốn kiểm thử chắc chắn thì có thể tiến hành đọc ghi dữ liệu trên các phân vùng mới đó.

👓 Giờ ta sẽ tiến hành sử dụng tính năng mở rộng-thu hẹp dung lượng của phân vùng mà LVM hỗ trợ.
Sử dụng câu lệnh `lvresize -L [+|-][Size] <vgname>/<lvname>`.
 + TH1: thu hẹp dung lượng của test1 test3, giảm xuống mỗi phân vùng còn 5 GiB.

<img src="https://user-images.githubusercontent.com/79830542/170435194-e627f9c1-4829-4ed8-9f7c-1b91ab5f74f2.png" width="500">

Giảm thành công dung lượng của Logical volume test1 và test3 xuống còn 5 GiB.

 + TH2: mở rộng dung lượng của Logical volume test2 lên khoảng 600 GiB.

<img src="https://user-images.githubusercontent.com/79830542/170436607-9226a662-36e1-47be-8bfb-6b09718aab15.png" width="500">

♨️ _Việc thay đổi kích thước của Logical Volume phụ thuộc vào dạng file system mà nó được cấu hình. Ví dụ với dạng `ext` thì được còn với dạng `xfs` thì hiện tại chỉ tăng không giảm được. Và ta có thể tuỳ ý cấu hình file system theo nhu cầu sử dụng nên có thể tuỳ thuộc vào nhu cầu đểu cấu hình cho phù hợp._

👓 Test tính năng xoá bỏ phân vùng của LVM
Muốn xoá bỏ 1 phân vùng nào đó, trước tiên ta phải unmount chúng. Ta sử dụng lệnh `umount /dev/Phân_vùng_cần_loại_bor`. Ở đây ta sẽ thử với phân vùng test2, đang chiếm giữ khoảng 620 GiB.
 - B1: `umount /dev/test2`

<img src="https://user-images.githubusercontent.com/79830542/170437954-b5c159c9-a08f-4b6e-9a9f-8c23fc03faf9.png" width="500">

 - B2: xoá bỏ Logical volume test2, `lvremove /dev/tên_volume_group/tên_logical_volume`

<img src="https://user-images.githubusercontent.com/79830542/170438633-5451b605-bc72-4059-9d43-1f3865bedc60.png" width="500">

♨️ _Chú ý: trong bài sử dụng máy lab hoàn toàn không chứa dữ liệu gì quan trọng nên có thể thoải mái thêm sửa tuỳ với các ổ cứng có trong máy, khi thử những phương pháp quản lý ổ cứng mới thì nên chắc chắn ổ cứng không có dữ liệu quan trọng.
 Trên đây là bài lab về những thao tác cơ bản nhất của LVM. Những thứ chi tiết và phức tạp hơn sẽ được thực hành về sau này._

<a name="III.references"></a>
# III. Tài liệu tham khảo
[1. Các phân vùng](https://wikimaytinh.com/partition-la-gi-phan-vung-la-gi.html)

[2. Ưu nhược điểm](https://blog.cloud365.vn/linux%20tutorial/tong-quan-lvm/)

[3. Tìm hiểu về LVM](https://vinasupport.com/lvm-la-gi-tao-vao-quan-ly-logical-volume-manager/)

[4. The Complete Beginner's Guide to LVM in Linux](https://linuxhandbook.com/lvm-guide/)

[5. lvm-what-is-lvm](https://github.com/hocchudong/thuctap012017/blob/master/TVBO/docs/LVM/docs/lvm-what-is-lvm.md#using)

[What is /dev/sda in Linux?](https://www.tec4tric.com/linux/dev-sda-in-linux)
