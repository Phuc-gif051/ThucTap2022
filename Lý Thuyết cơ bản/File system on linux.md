# Mục lục
[I. Định dạng file system](#I) 
 - [1. Các định nghĩa cơ bản](#I.1) 
 - [2. Các định dạng file system trên linux](#I.2) 
   - [2.1 Trên Windows](#I.2.1)
   - [2.2 Trên MacOS](#I.2.2)
   - [2.3 Trên Linux](#I.2.3)   


[III. Tài liệu tham khảo](#III) 

# <a name="I">I. Định dạng file phổ biến trên linux</a>

## <a name="I.1">1. Các định nghĩa cơ bản</a>
 - Filesystem là các phương pháp và các cấu trúc dữ liệu mà một hệ điều hành sử dụng để theo dõi các tập tin trên ổ đĩa hoặc phân vùng. Có thể tạm dịch filesystem là hệ thống tập tin. File system được dùng để quản lý cách dữ liệu được đọc và lưu trên thiết bị. Thuật ngữ này cũng được sử dụng để chỉ một phân vùng hoặc ổ đĩa được sử dụng để lưu trữ các tập tin hoặc loại hệ thống tập tin. Hiểu đơn giản thì filesystem là các quy chuẩn về: cách thức cấp phát không gian lưu trữ cho file, quản lý thuộc tính của file; cách tổ chức, sắp xếp dữ liệu trên thiết bị sao cho việc tìm kiếm, truy cập tới dữ liệu được mau chóng và thuận tiện…

Với mỗi OS khác nhau thì ta cũng sẽ phải sử dụng các định dạng filesystem khác nhau:
    + Trên Window thì là NTFS, FAT..., 
    + Trên MacOS là HFS+,..., 
    + Trên Linux là ext, xfs,...
 - The journaling file system (JFS) công nghệ đi kèm trong hệ thống file system được IDM đề ra và phát triển từ những năm 1990. Về cơ bản nó là một “journal” của dữ liệu, mục đích của nó là theo dõi các thay đổi chưa được ghi lại (commit) đối với hệ thống file. Ngay cả sau khi có sự cố hoặc tắt máy đột xuất, bạn vẫn có thể truy cập phiên bản file mới nhất với khả năng bị lỗi thấp hơn.
 - Sector: đơn vị nhỏ nhất của 1 thiết bị lưu trữ chiếm một vị trí thực trên thiết bị lữu trữ và thường được tạo thành từ 3 phần: Header, ECC(Error-correcting Code), và khu vực thực sự lưu trữ dữ liệu. một sector của ổ đĩa cứng hoặc đĩa mềm có thể chứa 4096 byte thông tin.
 - Cluster size: về cơ bản đây là 1 cụm các sector, đây là thứ người dùng hay thấy. Nó đại diện cho lượng không gian đĩa nhỏ nhất có thể được sử dụng để chứa một tệp. Trên giao diện người dùng thì đây còn được gọi là Allocation unit size (AUS), người dùng có thể chọn từ 512 byte cho đến 2048kb cho 1 allocation unit size hay cluster size.

<img src="https://user-images.githubusercontent.com/79830542/171769593-28ffb1d5-2c00-4114-8fa0-49c26153b825.png" width="600">

Các loại kích thước file

```sh
Kilobyte - KB =	1024 Bytes
Megabyte - MB =	1024 KBs
Gigabyte - GB =	1024 MBs
Terabyte - TB =	1024 GBs
Petabyte - PB =	1024 TBs
Exabyte - EB = 1024 PBs
Zettabyte - ZB = 1024 EBs
Yottabyte - YB = 1024 ZBs
```


## <a name="I.2">2. Các định dạng file system phổ biến</a> 

_lưu ý: bài viết này chỉ tìm hiểu về linux là chủ yếu nên sẽ không đi sâu hay chi tiết vào các định dạng file system của các OS khác. Ta sẽ chỉ điểm qua chúng._

### <a name="I.2.1" >2.1 Trên Windows </a>
||FAT32|	NTFS|	exFAT|
|:---:|:---:|:---:|:---:|
|Dung lượng tối đa 1 file|	4 GB|	16 TB|	131.072 TB	|
|Dung lượng tối đa 1 phân vùng|	32 GB, một số OS hỗ trợ 2 TB|	16.777.216 TB|	16.777.216 TB|	
|Chiều dài tên file tối đa|	255 kí tự|	255 kí tự|	255 kí tự|
|Hỗ trợ journaling|	Không|	Có|	Có|	
|Tính tương thích	Cao/Thấp| Cao|	Trung bình (Windows)|	Thấp|
|Mục đích sử dụng|	Ổ USB rời, thẻ nhớ, thiết bị lưu trữ cần đọc bởi nhiều máy|	Ổ cứng trong cho máy chạy Windows, ổ cứng rời|Ổ USB rời, thẻ nhớ, ổ flash|

Xem thêm chi tiết hơn [tại đây](https://tinhte.vn/thread/su-khac-biet-giua-cac-dinh-dang-file-system-pho-bien-fat32-vs-exfat-vs-ntfs.2546955/)

### <a name="I.2.2" >2.2 Trên MacOS</a>
 - Apple File System (APFS) là hệ thống tệp mặc định cho máy tính Mac đang sử dụng macOS 10.13 trở lên, nổi bật với mã hóa mạnh mẽ, chia sẻ không gian, ảnh chụp nhanh (snapshots), định cỡ thư mục nhanh và hệ thống tệp cơ bản được cải tiến. APFS được tối ưu hóa cho ổ lưu trữ Flash/SSD được sử dụng trong các máy tính Mac gần đây, bạn có thể sử dụng APFS với các hệ thống cũ hơn có các ổ đĩa cứng (HDD) truyền thống và ổ lưu trữ bên ngoài, được gắn trực tiếp. macOS 10.13 trở lên hỗ trợ APFS cho cả ổ đĩa khởi động và ổ đĩa dữ liệu.

    APFS sẽ phân bổ dung lượng ổ đĩa trong bộ chứa theo yêu cầu. Dung lượng trống của ổ đĩa được chia sẻ và có thể được phân bổ cho bất kỳ ổ đĩa riêng lẻ nào trong bộ chứa khi cần. Nếu muốn, bạn có thể chỉ định các kích cỡ hạn mức và kích cỡ đặt trước cho từng ổ đĩa. Từng ổ đĩa sẽ chỉ sử dụng một phần của toàn bộ bộ chứa, do đó, dung lượng khả dụng là tổng kích cỡ của bộ chứa trừ đi kích cỡ của tất cả các ổ đĩa trong bộ chứa.

- Mac OS Extended là hệ thống tệp mặc định được sử dụng bởi mọi máy Mac từ năm 1998 đến 2017, khi APFS thay thế nó. Cho đến ngày nay, nó vẫn là hệ thống tệp mặc định cho các ổ cứng cơ và lai, cả khi cài đặt macOS và trong khi định dạng các ổ đĩa ngoài. Điều này một phần vì những lợi ích của APFS không rõ ràng trên các ổ đĩa cơ.

   Nếu bạn đã có một ổ cứng cơ học và bạn dự định chỉ sử dụng nó với máy Mac, có lẽ tốt nhất là gắn bó với Mac OS Extended. Và bất kỳ ổ đĩa nào cần hoạt động với các máy Mac cũ hơn, chạy El Capitan hoặc cũ hơn, hoàn toàn phải được định dạng với Mac OS Extended, vì APFS không tương thích với các máy tính đó.

 - Cả 2 dạng trên khi sử dụng thì ta không cần phải quan tâm đến kích thước tối đa của 1 file hay của phân vùng (chúng đều rất lớn). Có hỗ trợ Journaling, thậm chí tên file còn có thể đặt không giới hạn.
Tham khảo [tại](https://support.apple.com/vi-vn/guide/disk-utility/dsku19ed921c/mac)

### <a name="I.2.3" >2.3 Trên Linux</a>

Để xem các hệ thống tệp mà mkfs có thể tạo, hãy nhập “mkfs” rồi nhấn phím Tab hai lần.

<img src="https://user-images.githubusercontent.com/79830542/171778909-c7fe0ecf-fcab-43a3-ba2f-3cddd7d08ea8.png" width="500">

Trên hình là hệ thống đang chạy Centos 7.

 - Ext – Extended file system: là định dạng file hệ thống đầu tiên được thiết kế dành riêng cho Linux. Có tổng cộng 4 phiên bản và mỗi phiên bản lại có một tính năng nổi bật. Phiên bản [Ext](https://en.wikipedia.org/wiki/Extended_file_system) đầu tiên là phần nâng cấp từ file hệ thống Minix được sử dụng tại thời điểm đó nhưng lại không đáp ứng được nhiều tính năng phổ biến ngày nay. Và tại thời điểm này, chúng ta không nên sử dụng Ext vì có nhiều hạn chế, không còn được hỗ trợ nhiều distribution.
 - Ext2: [Ext2](https://en.wikipedia.org/wiki/Ext2) là người kế nhiệm của Ext. Ext2 đồng thời hỗ trợ dung lượng ổ cứng lên 2TB. Ext2 không sử dụng journal cho nên sẽ có ít dữ liệu được ghi vào ổ đĩa hơn. Do lượng yêu cầu viết và xóa dữ liệu khá thấp nên nó phù hợp với các thiết bị lưu trữ gắn ngoài như thẻ nhớ, USB,… phục vụ trên môi trường Linux
 - Ext3: Đây là sự kế thừa của Ext2 và có thể được coi là Ext2 với tính năng ghi nhật ký, bảo vệ hệ thống tệp của bạn khỏi bị hỏng dữ liệu do sự cố và mất điện đột ngột. Có thể tương thích ngược với Ext2.
 - Ext4: Ext4 là hệ thống tệp tiêu chuẩn cho các bản phân phối Linux. Nó là một hệ thống tệp vững chắc, đã được thử nghiệm và đáng tin cậy. Nó có các tính năng giảm phân mảnh tệp và có thể được sử dụng với các ổ đĩa, phân vùng và tệp lớn hơn Ext3. Như vậy, chúng ta có thể dễ dàng kết hợp các phân vùng định dạng Ext2, Ext3 và Ext4 trên cùng 1 ổ đĩa để tăng hiệu suất hoạt động.
 - BtrFS – Better FS: được phát triển bởi Oracle và có nhiều tính năng giống ReiserFS. BtrFS hỗ trợ tính năng pool trên ổ cứng, tạo và lưu trữ snapshot, nén dữ liệu ở mức độ cao, chống phân mảnh dữ liệu nhanh chóng. Được thiết kế riêng dành cho các doanh nghiệp có quy mô lớn.
 - FAT: File Allocation Table được thiết kế cho đĩa mềm bởi một tập đoàn các công ty máy tính nặng ký trong ngành công nghiệp máy tính. Nó được giới thiệu vào năm 1977. Lý do duy nhất bạn sử dụng hệ thống tệp không hỗ ghi nhật ký này là để tương thích với các hệ điều hành không phải Linux.
 - XFS: được phát triển bởi Silicon Graphics năm 1994 để hoạt động với hệ điều hành riêng biệt của hãng, và sau đó chuyển sang Linux năm 2001. Khá tương đồng với Ext4 về một số mặt như: hạn chế được tình trạng phân mảnh dữ liệu, không cho phép các snapshot tự động kết hợp với nhau, hỗ trợ nhiều file dung lượng lớn, có thể thay đổi kích thước file dữ liệu,… nhưng không thể shrink – chia nhỏ phân vùng XFS. Phù hợp để áp dụng vào mô hình server media vì khả năng truyền tải file video rất tốt. Nếu hoạt động trên máy tính cá nhân thì đây không phải là lựa chọn tốt khi so sánh với Ext, vì hiệu suất hoạt động không khả thi, ngoài ra cũng không có tính năng gì nổi bật so với Ext3/4
 - NTFS: New Technology File System là một hệ thống tệp hỗ trợ ghi nhật ký của Microsoft được giới thiệu với Windows NT. Nó là sự kế thừa của FAT. Lý do duy nhất bạn sử dụng hệ thống tệp này là để tương thích với các hệ điều hành không phải Linux.
 - MINIX: Ban đầu được tạo ra bởi [Andrew S. Tanenbaum](https://en.wikipedia.org/wiki/Andrew_S._Tanenbaum) như một công cụ hỗ trợ việc học và dậy, [MINIX](http://www.minix3.org/) là viết tắt của “mini-Unix”. Ngày nay, nó nhằm cung cấp một hệ điều hành tự phục hồi và có khả năng chịu lỗi. Hệ thống tệp của MINIX được thiết kế như một phiên bản đơn giản của [Hệ thống tệp Unix](https://en.wikipedia.org/wiki/MINIX_file_system). Có lẽ nếu bạn đang phát triển chéo trên máy tính Linux và nhắm mục tiêu là nền tảng MINIX, bạn có thể sử dụng hệ thống tệp này. Hoặc có lẽ bạn cần khả năng tương thích với máy tính MINIX vì những lý do khác. Các trường hợp sử dụng cho hệ thống tệp này trên máy tính Linux không có nhiều, nhưng nó có sẵn.
 - VFAT: [Virtual File Allocation Table](https://en.wiktionary.org/wiki/VFAT), được giới thiệu với Windows 95 và loại bỏ giới hạn tám ký tự cho tên tệp. Có thể có tên tệp lên đến 255 ký tự. Lý do duy nhất bạn sử dụng hệ thống tệp này là để tương thích với các hệ điều hành không phải Linux.
 - CRAMFS: [Compressed ROM File System](https://en.wikipedia.org/wiki/Cramfs) là hệ thống tệp chỉ đọc được thiết kế cho các hệ thống nhúng và các mục đích sử dụng chỉ đọc chuyên dụng, chẳng hạn như trong quy trình khởi động của máy tính Linux. Thông thường, hệ thống tệp nhỏ, tạm thời, được tải đầu tiên để các quá trình bootstrap có thể được khởi chạy để chuẩn bị cho hệ thống khởi động “thực sự” được gắn kết.
 - MSDOS: Hệ thống tệp của Hệ điều hành Microsoft Disk. Được phát hành vào năm 1981, đây là một hệ thống tệp sơ cấp cơ bản nhất. Phiên bản đầu tiên thậm chí không có thư mục. Nó giữ một vị trí nổi bật trong lịch sử điện toán, nhưng ngoài khả năng tương thích với các hệ thống cũ, ngày nay có rất ít lý do để sử dụng nó.





# <a name="III">III. Tài liệu tham khảo</a>

[1. how-to-use-the-mkfs-command-on-linux](https://www.howtogeek.com/443342/how-to-use-the-mkfs-command-on-linux/#:~:text=The%20modern%20way%20of%20using,displayed%20in%20the%20terminal%20window.)

[2. explains-which-linux-file-system-should-you-choose](https://www.howtogeek.com/howto/33552/htg-explains-which-linux-file-system-should-you-choose/)

[3. Tìm hiểu khái niệm cơ bản về hệ thống file trong Linux](https://quantrimang.com/tim-hieu-khai-niem-co-ban-ve-he-thong-file-trong-linux-84900) 

[4. Tìm hiểu hệ thống tập tin và thư mục trên hệ điều hành Linux](https://quantrimang.com/he-thong-tap-tin-va-thu-muc-tren-linux-45046)

[5. Sự khác biệt giữa các định dạng file system phổ biến: FAT32 vs exFAT vs NTFS](https://tinhte.vn/thread/su-khac-biet-giua-cac-dinh-dang-file-system-pho-bien-fat32-vs-exfat-vs-ntfs.2546955/)

[6. Allocation Unit Size](https://sentayho.com.vn/cluster-size-la-gi.html)

[7. cluster-size](https://support.microsoft.com/en-us/topic/default-cluster-size-for-ntfs-fat-and-exfat-9772e6f1-e31a-00d7-e18f-73169155af95#:~:text=Cluster%20size%20represents%20the%20smallest,multiple%20of%20the%20cluster%20size)
