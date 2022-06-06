# Mục lục
[I. Giới thiệu chung 📖](#I.GT)

[II. Thực hành (lab) 🖥️](#II.Lab)
  - [1. Chuẩn bị](#II-1)
  - [2. Thực hành](#II-2)

[III. Tài liệu tham khảo](#III)


<a name="I.GT"></a>
# I. Giới thiệu chung 📖
Nhắc lại kiến thức một chút, đầu tiên đó là RAID là gì?
RAID là viết tắt của Redundant Array of Independent Disks; 
là một cách ảo hóa nhiều ổ cứng độc lập thành một hoặc nhiều mảng để cải thiện hiệu năng, dung lượng và độ tin cậy (tính sẵn sàng, bảo vệ dữ liệu). 
Tổng dung lượng của mảng tùy thuộc vào loại RAID mà bạn xây dựng, cũng như số lượng và dung lượng ổ đĩa. 
Tổng dung lượng này không phụ thuộc vào RAID mềm hay RAID cứng mà bạn sử dụng. Các loại RAID phổ biến hiện nay là 0, 1, 5, 10, 01.

Qua khoảng 30 năm phát triển (khoảng năm 1990) đến nay thì RAID không chỉ được áp dụng cho các máy chủ, hay các hệ thống lớn nữa. Mà đến nay RAID 
đã có mặt trên hầu hết các thiết bị, từ các hệ thống nhỏ (văn phòng, công ty) cho đến tận người dùng cá nhân (các máy máy tính để bàn, thậm chí là cả laptop)

Để đáp ứng được nhu cầu của đa dạng khách hàng như thế thì RAID đã phải phát triển nhiều khả năng triển khai, từ RAID cứng, RAID phần mềm, RAID kết hợp.
Trong bài viết này sẽ chỉ đề cập đến RAID phần mềm (software RAID), và thực hành sử dụng trên môi trường Centos 7.

Cách đơn giản nhất để miêu tả RAID mềm đó là tác vụ RAID chạy trên CPU trong hệ thống máy tính của bạn.
Một số RAID mềm bao gồm một bo mạch phần cứng, thoạt nhìn trong nó giống như RAID cứng. Do đó, điều quan trọng cần phải hiểu là 
RAID mềm sử dụng sức mạnh tính toán của CPU. 
Mã này cung cấp các tính năng RAID chạy trên CPU hệ thống, chia sẻ sức mạnh tính toán của CPU với OS và tất cả những ứng dụng. 
Nó không có thể được xem như 1 ứng dụng được cài vào để ta sử dụng như bao ứng dụng khác.

<a name="II.Lab"></a>
# II. Thực hành (Lab) 🖥️
_Thực hành trên môi trường Centos 7_

<a name="II-1"></a>
## 1. Chuẩn bị
 - Một vài ổ cứng hoặc phân vùng không chứa dữ liệu (ít nhất là 2)
 - Công cụ RAID mềm, có khá là nhiều nhưng chủ yếu sử dụng `mdadm`
    - Kiểm tra xem hệ thống đã có mdadm chưa, sử dụng `mdadm --version`, nếu hiện version thì tức là đã có cài đặt
    - Nếu chưa có, ta cần cài đặt, dùng `yum install -y mdadm`

## <a name="II-2" >2. Thực hành</a> 

B1: Trước khi tạo cần kiểm tra xem ta có bao nhiêu ổ cứng, chạy lệnh `fdisk -l |grep sd`

<img src="https://user-images.githubusercontent.com/79830542/171814129-fcf8818d-e813-44b9-b455-b3ed8974b3cd.png" width="600">

B2: Xác định được ổ cần cài raid ta kiểm tra xem ổ đó có đang tham gia vào cụm raid nào hay không, dùng lệnh `mdadm --examine /dev/sd[a-f]`

<img src="https://user-images.githubusercontent.com/79830542/171817949-6835faea-386b-4413-bb4d-c036ff571bb0.png" width="600">

Như trên hình, ta có thể hiểu đơn giản là các ổ từ a->e hiện không được cấu hình raid, còn ổ f được cấu hình raid với 2 phân vùng tham gia.

Tới đây có 2 trường hợp cần được lưu ý. 
 - Trường hợp 1 ổ cứng của bạn có dung lượng nhỏ, hoặc bạn được chỉ định cấu hình raid theo ý khách hàng, lúc này bạn không cần quan tâm quá nhiều, chỉ cần cấu hình raid cho ổ cứng được chỉ định ngay và luôn. 
 - Trường hợp 2, bạn có nhiều ổ cứng, ổ cứng dung lượng lớn mà không muốn cấu hình raid cho ngần nấy dung lượng, thì lúc này ta cần phải [phân vùng ổ cứng bằng `fdisk`](https://blogd.net/linux/quan-ly-phan-vung-dia-cung-tren-linux/) rồi tiến hành cấu hình raid cho từng phân vùng đó.

Sau đây sẽ tiến hành thực nghiệm theo 2 trường hợp trên.

#### Trường hợp 1:

B3: Sử dụng câu lệnh `mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdb /dev/sdc` để tiến hành cấu hình raid 0 cho 2 ổ cứng sdb và sdc. Trong đó
 - /dev/md0: trên cụm raid mà bạn muốn đặt, bắt buộc phải trong thư mục /dev, có thể đặt như trong ví dụ hoặc /dev/md/name_cụm_raid.
 - level: cấu hình raid mà bạn muốn dùng (0,1,5,6,10,01)
 - raid-devices: số lượng ổ cứng (phân vùng) dùng để cấu hình raid
 - /dev/sdb /dev/sdc: đường dẫn đến các ổ cứng (phân vùng) mà ta muốn cấu hình raid

Hiện tại ta chỉ quan tâm đến các thông số cơ bản như trên, sau này có khả năng thì sẽ đi sâu, cấu hình chi tiết hơn nữa.

<img src="https://user-images.githubusercontent.com/79830542/171822319-ca79b59e-c52e-40c3-a434-da3ada198cd9.png" width="600">

Tạo thành công cụm raid.

B4: định dạng loại file hệ thống sẽ dùng trên cụm raid, thường thì ta sẽ cấu hình giống với loại file system mà OS đang sử dụng. Để xem OS đang sử dụng loại file system nào thì dùng lệnh `lsblk -f`. Ở đây OS của mình đang dùng .xfs nên mình sẽ cấu hình cụm raid theo OS. Sử dụng lệnh `mkfs.xfs /dev/md0`

<img src="https://user-images.githubusercontent.com/79830542/171823292-7ef64419-c122-4b6c-a192-b47712b1b928.png" width="600">

Cấu hình hoàn tất.

B5: Cấu hình file system thành công, muốn sử dụng thì cũng như bao trường hợp khác, ta cần mount vào cho hệ thống biết và quản lý. Để chắc chắn hơn ta có thể sử dụng lệnh `partprobe /dev/md0` để khai báo với OS là có 1 phân vùng mới.

Tiến hành mount md0 vào cho hệ thống, dùng lệnh `mount /dev/md0 /vdisk`. Trong đó:
 - /dev/md0: phân vùng mà ta muốn muont cho hệ thống.
 - /vdisk: thư mục sẵn có trong hệ thống làm điểm mount, có thể tạo mới hoặc dùng thư mục sẵn có (ưu tiên tạo mới).

Thường thì mount thành công cũng sẽ không có thông báo gì, để kiểm tra đã mount thành công hay chưa sử dụng `lsblk` để kiểm tra mount point

<img src="https://user-images.githubusercontent.com/79830542/171824536-46fed5c2-8663-4264-b78c-8edb6cddf47d.png" width="600"> 

Như vậy, ta đã thành công tạo được cụm raid với tên md0, chạy raid0, gồm 2 ổ sdb sdc. Muốn xem chi tiết hơn về cấu hình ta dùng lệnh `cat /proc/mdstat`

<img src="https://user-images.githubusercontent.com/79830542/171825984-36a8ab94-1c0f-40fd-b3fa-a4244d755369.png" width="600"> 

Cấu hình thành công cho trường hợp 1.

#### Trường hợp 2: tôi có nhiều ổ cứng, dung lượng cao và tôi chỉ cần 1 phần nhỏ để cấu hình raid cho phù hơp với nhu cầu

B3: để cấu hình raid trên từng phân vùng của ổ cứng thì trước tiên ta phải có phân vùng đã. Tiến hành phân vùng ổ cứng trên ổ sdd, dùng lệnh `fdisk /dev/sdd` để sử dụng fdisk - trương trình giúp quản lý ổ cứng phổ biến trên Linux.

<img src="https://user-images.githubusercontent.com/79830542/171828708-7441ab7b-6465-4d13-bd86-57f31ceffacc.png" width="600">

 - Gõ 'm' nếu muốn xem chi tiết các lệnh (help), muốn tạo luôn phân vùng mới thì gõ `n`. 
 - Khi tạo phân vùng mới thì sẽ được tạo tối đa 4 phân vùng chính (primary - có thể cài OS lên đó), và phân vùng mở rộng (extended - thường chỉ dùng để lưu trữ). Ưu tiên chọn `p` 
 - Chọn nơi bắt đầu của phân vùng, nên để mặc định, rồi enter
 - Xác định nơi kết thúc của phân vùng, nếu để mặc định hệ thống sẽ tự động lấy toàn bộ dung lượng của ổ cứng hiện có. Nếu muốn xác định chính xác thì nhập vào dung lượng mong muốn `+dung lượng mong muốn (K, M, G)`

<img src="https://user-images.githubusercontent.com/79830542/171830361-d145127c-d8a0-4c9f-aa75-c9fa3c5c5f73.png" width="600"> 

 - Đã có phân vùng mới, cần phải tạo Linux RAID tự động trên các phân vùng này, để linux biết có thể can thiệp vào phân cùng đó, tiến hành cấu hình raid. Vẫn sử dụng fdisk để tạo Linux RAID tự động.
   + `fdisk /dev/sdd` để fdisk truy cập vào ổ sdd.
   +  Nhập `t` để chọn phân vùng.
   +  Nhập `fd` để chọn Linux raid auto (có thể nhập `l` để xem danh sách mã hex của các phương thức mà fdisk hỗ trợ).
   +  Nhập `p` để in những thay đổi (trong quá trình tạo phân vùng cũng có thể nhập `p` để xem phân vùng vừa được tạo).
   +  Nhập `w` để lưu những thay đổi.

 - Để chắc chắn ta cần khai báo với OS là có phân vùng mới được tạo, sử dụng `fdisk -l /dev/sdd` để xem đường dẫn của phân vùng mới. Sử dụng `partprobe /dev/sdd1` để khai báo với OS.

<img src="https://user-images.githubusercontent.com/79830542/171833761-ab1bb4a3-d8dc-4a69-b4c9-29b476b8f5de.png" width="600">

 - Lặp lại B3 để tiến hành tạo phân vùng mới trên ổ sde

B4: hoàn thành bước 3 sử dụng `lsblk` để kiểm tra lại phân vùng xem đã đúng với yêu cầu hay chưa.

<img src="https://user-images.githubusercontent.com/79830542/171834179-62b0c5c8-3cd7-400c-b898-1bc153b441f5.png" width="600">

Vì đây là 2 phân vùng ta vừa tạo nên có thể bỏ qua bước kiểm tra xem chúng có thuộc cụm raid nào không. Trong thực tế ta cần luôn kiểm tra để không gây xung đột, tốn thời gian không cần thiết. Sử dụng lệnh `mdadm --examine /dev/sd[d-e]1` để kiểm tra

<img src="https://user-images.githubusercontent.com/79830542/171835295-0b6813ad-6d5b-4076-9b09-eddb0b8dd7f8.png" width="600">

Đã đúng với yêu cầu đặt ra, tiến hành cấu hình raid cho 2 phân vùng này. Sử dụng `mdadm -C /dev/md1 -l raid0 -n 2 /dev/sd[d-e]1` cũng tương tự như câu lệnh trên nhưng là rút gọn của nó. Trong đó: 
 - C: Tạo RAID mới.
 - l: Level của RAID.
 - n: số lương thiết bị cần RAID.

<img src="https://user-images.githubusercontent.com/79830542/171836025-4b74f967-8b5f-43bd-8e75-37da56e486c2.png" width="600"> 

Đã có cụm raid, sử dụng `mdadm --detail /dev/md1` để kiểm tra thông tin cụm raid.
![image](https://user-images.githubusercontent.com/79830542/171836533-6e2c05bf-22d7-4fe5-b18f-a65f86a54f35.png)

B5: tiến hành cấu hình file system và mount vào hệ thống để có thể sử dụng

 - `mkfs.xfs /dev/md1`: cấu hình file system
 - `mount /dev/md1 /vdisk2`: mount vào với hệ thống qua điểm /vdisk2

![image](https://user-images.githubusercontent.com/79830542/171836949-1d9e8f33-c81e-4b1b-b382-ab7bfb7b8559.png)

Thành công cấu hình raid 0 cho trường hợp 2.

***_Lưu ý: các mount trong bài chỉ là mount tạm thời, khi reboot hệ thống thì sẽ mất điểm mount. Muốn hệ thống tự mount sau khi reboot thì ta cần cấu hình nó và lưu lại, xem chi tiết [tại đây](https://datnt.work/mount-va-unmount-trong-linux/)****

# <a name="III" >III. Tài liệu tham khảo 📚 </a>

[1. soft raid theo phân vùng](https://blogd.net/linux/software-raid-toan-tap-tren-linux/)

[2. Soft raid cả ổ cứng và cách xoá](https://galaxyz.net/cach-tao-mang-raid-voi-mdadm-tren-ubuntu-1604.1517.anews)

[3. Sử dụng fdisk để quản lý phân vùng](https://blogd.net/linux/quan-ly-phan-vung-dia-cung-tren-linux/)

