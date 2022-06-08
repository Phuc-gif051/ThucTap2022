# Mục lục
[I. Giới thiệu chung 📖](#I)

[II. Thực hành 🖥️](#II)
 - [1. Mount tạm thời](#II.1)
 - [2. Mount cố định](#II.2)
 - [3. Un-mount](#II.3)

[III. Tài liệu tham khảo 📚]()



<a name="I" ></a> 
# I. Giới thiệu chung 📖

Khác với Windows, trên Linux để có thể truy cập/sử dụng các thiết bị như USB, đĩa CD/DVD, file ISO, phân vùng ổ cứng, 
các tài nguyên được chia sẻ qua mạng (gọi chung là thiết bị)… thì trước hết các thiết bị này các được gắn kết (mount) 
vào 1 thư mục trống (gọi là mount point). Và khi muốn tháo gỡ thiết bị đang hoạt động khỏi hệ thống
thì bạn phải ngắt kết nối (umount) giữa thiết bị với mount point trước đó. 
Bài viết này sẽ hướng dẫn các bạn sử dụng 2 lệnh mount và umount trên Linux để thực hiện công việc gắn kết và tháo gỡ  
ổ cứng (HDD) trên Centos 7.

Khi bạn gắn thêm ổ cứng vào máy tính/server chạy hệ điều hành nhân Linux, hệ thống sẽ nhận ổ cứng đó với một device file đặt ở thư mục /dev.

Để kiểm tra danh sách ổ cứng và phân vùng được nhận trên Linux bạn sử dụng lệnh sau: `lsblk`. Để xem chi tiết hơn 1 vài thông tin về các phân vùng
vùng đó thì thêm hậu tố `-f` vào sau câu lệnh.

<img src="https://user-images.githubusercontent.com/79830542/172551842-17db829f-8ece-4de9-9c06-cd6cad15f691.png" width="600"> 

Ta sẽ thấy được 1 số thông tin quan trọng như: 
 - File system type: định dạng file system mà phân vùng đó đang được cấu hình
 - UUID: hiểu cơ bản thì đây là ID của phân vùng đó
 - Mountpoint: nơi mà phân vùng đó được mount vào với hệ thống.

Như hình bên trên thì thiết bị của ta có 1 phân vùng `vdc` chưa có mount point, ta sẽ tiến hành thực hành trên phân vùng này.


<a name="II" ></a>
# II. Thực hành 🖥️

## <a name="II.1" >1. Mount tạm thời</a>

🚩 Áp dụng cho các trường hợp bạn cần sử dụng ngay (các thiết bị di động USB, đĩa CD,...). Bạn vẫn sẽ được sử dụng các phân vùng này 1 các bình thường
nhưng khi khi khởi động lại hệ thống thì cần phải mount lại 1 lần nữa.

▶️ Để mount được 1 phân vùng nào đó trước tiên ta cần định dạng file system cho nó. Đối với các thiết bị rời, bạn nên lưu ý điều này vì khi cấu hình
file system thì ta sẽ phải xoá sạch dữ liệu trước đó.

Để định dạng file system ta dùng câu lệnh `mkfs.L X`, trong đó:
 - L: loại file system mà ta muốn định dạng, để xem OS hỗ trợ định dạng các loại file system nào ta nhập `mkfs` rồi nhấn `tab` 2 lần
 - X: đường dẫn đến phân vùng cần định dạng, chúng thường được lưu trong thư mục `/dev`

![image](https://user-images.githubusercontent.com/79830542/172554091-c07bd1a8-d079-4d69-aa07-67396d59787d.png)

🔽 Định dạng thành công cho phân vùng ***vdc***. Để mount được, ta cần 1 mount point. Thường là 1 thư mục trống trong hệ thống, nên tạo 1
thư mục mới, dùng lệnh `mkdir /vdisk2` để tạo 1 thư mục mới là **vdisk2** nằm trong thư mục **/**

🔽 Tiến hành mount phân vùng đã định dạng file system vào thư mục trống đã tạo. Sử dụng lệnh `mount X Y`, trong đó:
  - X: phân vùng (thiết bị) cần mount
  - Y: mount point (thư mục trống là điểm mount trong hệ thống)

Kiểm tra xem đã mount thành công hay chưa: `lsblk` hoặc `df -hT`
![image](https://user-images.githubusercontent.com/79830542/172556354-913328d1-5ed4-4a9a-8c15-8181a44582c6.png)

⏹️ Sau khi mount xong ta đã có thể sử dụng bình thường phân vùng đó. Nhưng khi khởi động lại thì sẽ mất mount point và ta phải tiến hành mount lại.

## <a name="II.2" >2. Mount cố định</a>
🚩 Áp dụng cho các ổ cứng, các trường hợp thêm phân vùng cho hệ thống sử dụng 1 cách cố định (mở rộng dung lượng, thay thế ổ cứng, có phân vùng mới,...).
Khi sử dụng cách này ta sẽ không lo bị mất mount point khi khởi động lại. Hệ thống sẽ tự động đọc file cấu hình và tự mount theo file cấu hình đó.

▶️ Mọi thứ làm như [mục 1](#II.1) chỉ khác là sau khi mount thành công ta sẽ tiến hành cấu hình trong file cấu hình của hệ thống. Nhằm tạo 1 
luồng dữ liệu cho hệ thống đọc khi khởi động và tiến hành tự mount theo dữ liệu ta đã khai báo.

Đến đây thì ta có 2 phương pháp để cấu hình.
  - Một là: sử dụng đường dẫn, ví dụ `/dev/vdc /vdisk defaults 0 0`. Nhưng trường hợp này thi thoảng gặp lỗi, OS lại đặt mount point lẫn lộn gây
bất ngờ không nhỏ cho ta trong quá trình sử dụng.
  - Hai là: sử dụng UUID của phân vùng. Đây là cách phổ biến nhất vì mỗi phân vùng (thiết bị) chỉ có 1 UUID duy nhất, không thể nhầm lẫn. Sau đây ta sẽ sử dụng cách này.

▶️ Để xem được UUID của phân vùng (thiết bị) nào đó ta dùng lệnh `blkid X` trong đó: X là đường dẫn đến phân vùng ta muốn biết ID.

![image](https://user-images.githubusercontent.com/79830542/172560384-8975f72e-31dd-43af-be21-fb9807446ae5.png)

Có thể thấy UUID của 1 phân vùng (thiết bị) rất là dài và ta cần sử dụng thêm 1 công cụ nữa đó là trình chỉnh sửa tệp `vi` có sẵn trong mọi nhân Linux.

▶️ Tuy nhiên `blkid` lại không phải là 1 tệp, ta cần lấy nội dung của nó đưa vào trong 1 tệp để có thể can thiệp. Sử dụng phương pháp 
`blkid /dev/vdc > blkid.txt`, hiểu cơ bản thì lệnh này sẽ copy nội dung lấy được từ câu lệnh `blkid` đưa vào tệp `blkid.txt`.

Đã có tệp nội dung ID, ta sử dụng `vi blkid.txt /etc/fstab` để tiến hành khai báo cấu hình mà ta đặt cho phân vùng. Trong đó:
  + blikid.txt: file txt có ID của phân vùng mà ta đã mount, đã tạo ra ở bước trên.
  + /etc/fstab: file cấu hình mà hệ thống đọc trong lúc khởi động để tự mount các phân vùng.

▶️ Trong `vi`:
  - copy: đầu tiên `ctrl V` để khai báo hành động copy, dùng các phím mũi tên để lựa chọn nội dung muốn copy. Lựa chọn xong nhần `y` 2 lần để copy.
  - Sau khi nhấn `y` 2 lần ứng dụng sẽ tự chuyển sang chế độ điều khiển. Trên bàn phím nhấn giữ `Shift` rồi nhấn phím `:`. Ta sẽ thấy như hình dưới

<img src="https://user-images.githubusercontent.com/79830542/172564963-77a1ccf1-3499-4f1a-b335-d9e722fc7a82.png" width="600">

Nhập `n` (`N` để chuyển đến file phía trước) rồi `Enter` để chuyển sang file tiếp theo, ở đây là file `fstab`. Nếu hiện thông báo nào thì ấn `Enter` thêm lần nữa là được.

  - Sau khi chuyển sang file `fstab` ta lựa 1 chỗ trống rồi nhấn `p` để paste nội dung đã copy ở trên. Nếu không có chỗ trống nào thì 
  - nhấn phím `i` để vào chế độ `Insert` của `vi` rồi tạo khoảng trống. Thoát chế độ `Insert` bằng phím `Esc` rồi paste nội dung. 

<img src="https://user-images.githubusercontent.com/79830542/172567307-83a8f710-f231-4375-b7fb-4eeb1fd1f3ab.png" width="600">

Sau khi đã paste UUID thành công ta sẽ hoàn thành câu khai báo tương tự như như các trường có trong file. Với:
  - UUID= : UUID của phân vùng mà ta đã paste khi nãy
  - Trường thứ 2 (mount point): thư mục mà ta sẽ mount trong hệ thống (dạng đường dẫn)
  - Trường thứ 3 (file system): dạng file system mà phân vùng (thiết bị) đó được cấu hình.
  - Trường thứ 4 (các options): các quyền, các cách thức truy cập, sử dụng với phân vùng (thiết bị) đó, có rất nhiều các options. Thường để là defaults nếu bạn không phải dân chuyên giống mình :D, xem thêm các options [tại đây](https://man7.org/linux/man-pages/man8/mount.8.html)
  - Trường thứ 5 (số 0 đầu tiên): đây là lựa chọn cho phương thức "dumping" - 1 phương thức backup khá lỗi thời cho trường hợp hệ thống tắt đột ngột. Với giá trị "0" - không sử dụng, "1"-có sử dụng.
  - Trường thứ 6 (số 0 thứ 2): lựa chọn cho phương thức "fsck" trên linux. Hiểu cơ bản đây là 1 phương thức kiểm tra xem các phân vùng (thiết bị) có bị lỗi gì hay không. Hoạt động tốt nhất khi các phân vùng (thiết bị) đó được cấu hình ở các dạng có hỗ trợ journaling (ext3-4, xfs, ReiserFS,...). Với giá trị "0" là bỏ qua, tính ưu tiên thì tịnh tiến dần từ 1.  

Sau khi hoàn tất các trường nhấn `Esc` để thoát chế độ `Insert`, rồi nhấn giữ `Shift` -> nhấn phím `:`, rồi nhập `wq` để lưu và thoát trình `vi`.

<img src="https://user-images.githubusercontent.com/79830542/172575683-63f96138-be16-453f-9ce7-cad66b069cc5.png" width="600">

⏹️ Có thể sử dụng `lsblk` hoặc `df -hT` để kiểm tra lại mount point

⚠️ _Lưu ý: các chú thích về các trường ở trên hình là do mình tự thêm vào để ghi nhớ, trong thực thế thì sẽ không có các chú thích đó, nhưng các trường đều đúng 1 thứ tự như thế._

## <a name="II.3" >3. Un-mount</a>

Un-mount thì đơn giản hơn hơn mount, chỉ cần dùng lệnh `umount X`, trong đó X là mount point. Nếu hệ thống báo phân vùng (thiết bị) đang bận (busy) thì sử dụng lệnh `umount -l X`.
Chú ý là lệnh un-mount là `umount` chứ không phải `unmount` đâu nhé.

![image](https://user-images.githubusercontent.com/79830542/172577708-391bef1a-05d5-49ae-b645-03a78cdf61f9.png)

Un-mount thành công, trong trường hợp bạn đã chỉnh sửa trong file `fstab` thì cần xoá trong cả file đó.

## <a name="II.4" >4. Trường hợp mất phân vùng (thiết bị bị hỏng)</a>

🚩 Trường hợp này được thành trên máy ảo nên có thể an toàn hơn trên máy vật lý. Ưu tiên thực hành trường hợp này trên máy ảo để bảo vệ phần cứng của bạn.

Đầu tiên, khi mất 1 phân vùng nào đó mà đã mount thì OS chưa thể nhận ra ngay lập tức. Chỉ khi khởi động lại, ta sẽ dễ dàng nhận thấy qua biểu hiện đầu tiên đó là khởi động chậm hơn bình thường. Sau khi khởi động lên ta sẽ nhận được thông báo như sau:

<img src="https://user-images.githubusercontent.com/79830542/172585821-21edb608-bc53-4097-81af-b9e42dcbada9.png" width="600">

Đây là chế độ dành cho người quản trị (quyền root) truy cập vào hệ thống khi OS khởi động lên và phát hiện lỗi ở ổ cứng của hệ thống. Thông thường ta sẽ phải kiểm tra tất cả các lỗi có thể xảy ra (hệ thống LVM bị lỗi, mount lỗi, có thể cả RAID lỗi,... thường thì 2 trường hợp đầu hay gặp hơn). 

Ở bài lab này ta biết rõ lỗi là do mount bị mất ổ cứng. Để truy cập vào hệ thống ở trường hợp này đầu tiên ta cần nhập mật khẩu cho root use rồi Enter. Truy cập được vào hệ  thống tiến hành sử dụng lệnh `mount -a` để kiểm tra xem bị lỗi ở đâu.

<img src="https://user-images.githubusercontent.com/79830542/172587082-e11c4375-7b9d-4a9b-88f3-df6b001ea05e.png" width="600">

Như trên hình, OS không thể tìm thấy 2 UUID đó. Phân vùng (thiết bị) có 2 ID đó có thể đã hỏng, bị rút ra,... Để khởi động hệ thống lên và chạy các dịch vụ trước khi tiến hành khắc phụ sự cố thì ta sẽ xoá bỏ việc tự mount vào 2 ID đó. Dùng `vi /etc/fstab` để truy cập vào tệp cấu hình và chỉnh sửa nó. Nhanh gọn nhất là nên thêm `#` vào đầu câu khai báo, hoặc bạn có thể xoá bỏ chúng luôn cũng được.

Chỉnh sửa xong lưu lại và thoát khỏi `vi` reboot hệ thống sẽ khởi động lại như bình thường, tiến hành chạy các dịch vụ và tìm cách khắc phục việc mất dữ liệu.

# <a name="III" >III. Tài liệu tham khảo 📚</a>

[1.What Is the Linux fstab File, and How Does It Work?](https://www.howtogeek.com/howto/38125/htg-explains-what-is-the-linux-fstab-and-how-does-it-work/)

[2.How to Mount and Unmount Storage Devices from the Linux Terminal](https://www.howtogeek.com/414634/how-to-mount-and-unmount-storage-devices-from-the-linux-terminal/)

[3.Mount / Umount Ổ Cứng Hay Thiết Bị Trên Linux](https://itfromzero.com/linux/mount-umount-o-cung-hay-thiet-bi-tren-linux.html)

[4. Tài liệu tiếng Nhật](https://kazmax.zpp.jp/linux_beginner/mount_hdd.html)

[5. Tài liệu chi tiết về mount](https://man7.org/linux/man-pages/man8/mount.8.html)

