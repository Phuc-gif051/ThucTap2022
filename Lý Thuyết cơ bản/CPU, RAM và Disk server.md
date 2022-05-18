# Mục lục 📇
[I. Lý thuyết](#I.LyThuyet)
 - [1. CPU](#1.CPU)
 - [2. RAM ECC](#2.RAM)
    - [2.1. Các loại RAM ECC](#21a.CacloaiRAM) 
      - [a. RAM buffered](#RAMbuff)
      - [b. RAM unbuffered](#RAMunBuff)
 - [3. Disk (ổ cứng)](#3.Disks)
[II. Thực hành 🖥️ (lab)](#II.Lab)
[Tài liệu tham khảo](#tailieu) 

<a name="I.LyThuyet"></a>
# I. Lý thuyết 📙
<a name="1.CPU"></a>
## 1. CPU 🖥️
**a) Định nghĩa và cấu tạo**

CPU( Central Processing Unit) là bộ xử lý trung tâm, là các mạch điện tử trong máy, nhiệm vụ của CPU là xử lý thông tin,
tính toán các dữ liệu, nhận biết các thao tác của người dùng để điều khiển các hoạt động của máy tính điện tử.
Về cơ bản CPU được cấu tạo từ hàng triệu linh kiện bán dẫn siêu nhỏ (các transistor), được chia thành 2 phần:
 - Control Unit: có chức năng chính là “biên dịch” thao tác người dùng sang ngôn ngữ máy (machine language) từ đó giúp con người ra lệnh cho máy tính thông qua các thao tác.
 - Arithmethic Logic Unit: giải quyết những bài toán với những con số hoặc nhưng bài toán logic. Kết quả sau đó sẽ được sử dụng để xử lý thông tin.
 - Thanh ghi (Register): đây là bộ phận có nhiệm vụ thực hiện thao tác ghi mã lệnh trước khi tiến hành việc xử lý và ghi kết quả sau khi được xử lý.
**b) Các thông số chung**
 - Core (Nhân): các nhân của CPU sẽ đảm nhiệm những quá trình xử lý khác nhau, thông thường những CPU có càng nhiều nhân càng tốt vì điều đó sẽ giúp CPU xử lý các chương trình đa tác vụ.
 - Threads (luồng) cho ta biết có bao nhiêu đường đưa dữ liệu cho CPU xử lý. Nếu càng có nhiều Threads, dữ liệu được lưu thông dễ dàng và hiển nhiên kết quả là CPU sẽ xử lý nhanh hơn.
 - Tốc độ của CPU (xung nhịp): mô tả tốc độ đóng và mở của bóng bán dẫn trong bộ xử lý, với đơn vị là GHz. Ví dụ 1 CPU có thông số là 2,5 GHz tức là nó thực hiện được 2,5 tỷ chu kỳ trong 1s. Thường thì con số này càng lớn thì CPU càng mạnh và giá thành cũng càng đắt đỏ.
 - FSB (Front Side Bus): là tốc độ truyền tải dữ liệu ra vào CPU hay là tốc độ dữ liệu chạy qua chân CPU. Đây là tốc độ giao tiếp của CPU với mainboard. Với các công nghệ mới hiện nay như: Intel QuickPath Interconnect (QPI), Ultra Path Interconnect (UPI),.. thì tốc độ chuyền tải dữ liệu lên đến vài GB hoặc vài chục GB/s (đơn vị tính thường thấy là GT/s - gigatransfers per second). Xem thêm [tại đây](https://www.diendanmaychu.vn/showthread.php/1287-QPI-l%C3%A0-g%C3%AC-Nh%E1%BB%AFng-%C4%91i%E1%BB%81u-c%E1%BA%A7n-bi%E1%BA%BFt-v%E1%BB%81-QPI)
 - Bộ nhớ Cache: bộ nhớ đệm của CPU dùng để lưu trữ các lệnh chuẩn bị được xử lý của CPU. 
Bộ nhớ đệm càng lưu trữ được nhiều thì hiệu suất của CPU càng cao.
 - Đối với server chạy 24h/ngày, 7 ngày/tuần thì điện năng tiêu thụ cũng khá là quan trọng, cần phải lưu tâm đến. Thường nó sẽ được hiển thị ngay trên web-site mua hàng. Mỗi loại có lượng tiêu thụ khác nhau, thường được tính bằng Watt (W).
 - Một số chữ cái hậu tố đi kèm như ví dụ sau:

| Mẫu máy tiêu biểu | Hậu tố | Ý nghĩa hậu tố| Giải thích|
|:---:|:---:|:---:|:---:|
| Dell XPS 13 9365 i7-7Y75 | Y | Extremely low power | CPU 2 lõi siêu tiết kiệm điện| 
| Dell Latitude E7440 Core i7 4600U | U | Ultra low power | CPU 2 lõi tiết kiệm điện|
| Dell Latitude E6540 Core i7 4600M | M | Mobile Processor | CPU tiêu chuẩn với TDP 17-35W|
| Dell Precision M4800 Core i7 4800QM | QM |Quad core Mobile | CPU lõi tứ hiệu năng cao|
| Acer Nitro V15Core i5 4210H | H | Hight Performamce graphics | CPU hiệu năng đồ họa cao với TDP 45W|
| MSI GS63VR 7RF Core i7 7700HQ	| HQ | Hight Performamce graphics Quad core	| CPU cao cấp, hiệu năng đồ họa cao có lõi tứ.|

Dòng CPU máy chủ Intel Xeon và những mã cập nhật gần đây, [xem chi tiết](https://www.thegioimaychu.vn/blog/tong-hop/dong-cpu-may-chu-intel-xeon-va-nhung-ma-cap-nhat-gan-day-p5111/)

<a name="2.RAM"></a>
## 2. RAM (Random Access Memory) 🐏

<a name="21.RAM ECC"></a>
**RAM ECC (Error Checking and Correction) - RAM cho máy chủ**
Một thanh RAM ECC là một thanh RAM có khả năng điều khiển được dòng dữ liệu ra và vào. Trong quá trình xử lý dữ liệu CPU sẽ không xử lý trên ROM mà xử lý tất cả trên RAM. Do đó, đối với một thanh RAM thông thường (non-ecc RAM) thì trong quá trình truyền tín hiệu ở tốc độ cao thì rất dễ dẫn đến hiện tượng xung đột (crash).

Khi xung đột xảy ra thì thanh RAM thường phải nạp lại toàn bộ dòng dữ liệu vì chúng không có khả năng quản lý được dòng dữ liệu. Đối với RAM ECC thì khi xung đột xảy ra, chúng chỉ cần yêu cầu hệ thống gửi lại đúng gói dữ liệu (packet) bị xung đột. Do đó, Ram ECC có độ ổn định và hiệu năng rất cao. 
Tất cả các RAM dành cho máy chủ đều đòi hỏi ích nhất phải có ECC.

Tuy nhiên cũng sẽ có một số nhược điểm của việc sử dụng RAM ECC, mặc dù không quá nghiêm trọng cũng phải được xem xét kỹ. 
Đầu tiên, RAM ECC sẽ chậm hơn một chút so với RAM truyền thống, đặc biệt là trong việc sửa lỗi khi kiểm tra tất cả dữ liệu đã đi qua nó. 
Một nhược điểm khác mà bạn sẽ phải đối mặt khi sử dụng RAM ECC là chi phí sử dụng sẽ cao hơn. 

<a name="21a.CacloaiRAM"></a>
### 2.1 Các loại RAM ECC (Error Checking and Correction) phổ biến 🌠
Có 2 loại RAM chính là: Buffered và unbuffered

<a name="RAMbuff"></a>
#### a. RAM buffered 🌟
RAM buffered là loại RAM có 1 [bộ đệm](https://quantrimang.com/ky-thuat-khai-thac-loi-tran-bo-dem-to-chuc-bo-nho-stack-goi-ham-shellcode-1782) là chip xử lý nhận thông tin trực tiếp từ CPU. Chip đệm này sau đó gửi thông tin sẽ được xử lý bởi các chip khác trên RAM. 
Điều này cho phép CPU gửi thông tin đến một mục tiêu thay vì gửi thông tin đến các chip riêng lẻ trên RAM. VD: Một thanh RAM 10600 điển hình sẽ có khoảng 18 chip đệm, do đó, bằng cách được trang bị một bộ đệm, CPU sẽ tối ưu hóa được hệ thống đường dẫn để gửi thông tin đến.

<img src="https://user-images.githubusercontent.com/79830542/166854428-a1639ac4-bfec-4dae-864e-5ac2e2d11ef4.png" width=800>

Một số loại RAM buffered tiêu biểu

| Loại RAM | Định nghĩa | Cách hoạt động |
|:---:|:---:|:---:|
| RAM Registered (đây là dòng tiêu biểu và phổ biến nhất hiện nay) | hay còn gọi là ECC RDIMM là bộ nhớ có chứa các thanh ghi | các lệnh truy xuất được gửi đến thanh ghi trước rồi mới chuyển tới mô-đun bộ nhớ, chờ xử lý. |
| RAM Fully Buffered | Hay còn được gọi là FB-DIMM là một công nghệ sản xuất ram với mục tiêu đặt ra là để phục vụ phát triển cho server bằng cách gia tăng tốc độ tối đa dựa trên công nghệ ram server (DIMM-ECC) cũ và tăng tối đa sự ổn định, độ tương thích | Loại RAM này về bản chất là một phiên bản cũ hơn của RAM Registered. Mặt hạn chế của FB-DIMM là chạy nóng hơn so với thanh ram DDR2 thông thường. |
| RAM Load Reduced | RAM Load Reduced (LRDIMM) là một phiên bản mới hơn của RAM buffered. | Biến thể của FB-DIMM sẽ giải quyết một số vấn đề về hiệu suất và sức mạnh mà RAM FB-DIMM gây ra trong quá trình chuyển đổi tín hiệu từ nối tiếp sang song song. |

**Lưu ý:** Các loại RAM FB-DIMM và LRDIMM được thiết kế theo những cách hơi khác so với RAM RDIMM và sẽ không thể hoán đổi được cho nhau trên tất cả các bo mạch.

<a name="RAMunBuff"></a>
#### b. RAM unbuffered hay còn gọi là ECC UDIMM 🌟
RAM ECC UDIMM là bộ nhớ không có các bộ đệm hoặc thanh ghi được thiết kế trên mô-đun RAM mà thay vào đó, 
các thiết bị này được thiết kế trên bo mạch chủ. Ram ECC UDIMM có các lệnh truy xuất bộ nhớ 
được đưa trực tiếp đến mô-đun bộ nhớ nhanh hơn ECC RDIMM vì không phải gửi gián tiếp qua thanh ghi.

Trong các hệ thống sử dụng RAM không có bộ đệm (unbuffered RAM), CPU sẽ liên lạc trực tiếp với các chip bộ nhớ riêng lẻ, 
do đó gửi thông tin sẽ được xử lý tới từng chip trên thanh RAM. Mặc dù điều này cho phép hệ thống có thể mở rộng hơn một chút cũng như linh hoạt hơn một chút, nhưng nó cũng đòi hỏi CPU phải có sức mạnh xử lý tốt hơn, và do đó, sẽ có ít không gian hơn để CPU thực hiện các tác vụ khác.

<img src="https://user-images.githubusercontent.com/79830542/166854138-03b37d68-20a8-4448-98ce-4aeac40ed106.png" width=800>


***Để CPU và RAM hoạt động với nhau một cách tốt nhất để tối ưu hoá hiệu suất của hệ thống thì FSB (Front Side Bus) của CPU và bus của  RAM tối thiểu phải bằng nhau. Xem chi tiết hơn [tại đây.](https://quantrimang.com/ram-may-tinh-va-nhung-dieu-can-biet-7849)***

<a name="3.Disks"></a>
## 3. Disk (ổ cứng) 🕹️

### 3.1 Ổ cứng là gì?

Ổ cứng là thiết bị phần cứng dùng để lưu trữ dữ liệu chính như: hệ điều hành, phần mềm và các tệp tin khác. Đầu cuối của ổ cứng chứa một cổng cho cap kết nối bo mạch. Cap sử dụng có thể là SATA hoặc SAS, phụ thuộc vào loại ổ đĩa. Hầu hết các ổ đĩa cứng đều có thiết lập jumper ở mặt sau để xác định cách bo mạch chủ nhận diện được ổ đĩa khi có nhiều hơn một ổ cứng.

Ổ cứng sẽ hỗ trợ và thay đổi một số khả năng của máy như: tốc độ khởi động, chép dữ liệu và mức độ an toàn của dữ liệu.

### 3.2 Có những loại ổ cứng server nào?

**Ổ cứng server (Ổ cứng máy chủ) cũng như các máy tính thông thường có hai loại chính: HDD (Hard Disk Drive) và SSD (Solid State Drive).**

💾 HDD (Hard Disk Drive): là một loại ổ cứng cho máy chủ giống như những máy tính thông thường. Tuy nhiên, do đặc thù của máy chủ đòi hỏi dung lương bộ nhớ lớn nên một server có thể gắn kèm nhiều HDD. Việc sở hữu một HDD server tốt sẽ đem lại cho người dùng rất nhiều lợi ích về: khả năng lưu trữ, tốc độ và khả năng truy xuất, bảo vệ dữ liệu. Ngoài ra, HDD có vai trò mật thiết trong việc gia tăng tuổi thọ cho máy chủ.


<img src="https://user-images.githubusercontent.com/79830542/166857433-7548012c-534e-4c32-8d38-d0b5657dd815.png" width="600">

Phổ biến hiện nay thường thấy nhất chính là HDD 2.5in và HDD 3.5in, có hai chuẩn giao tiếp phổ biến là:  
 - SATA (Serial Advanced Technology Attachment) - chuẩn giao tiếp truyền dữ liệu theo dạng song song
 - SAS (Serial Attached SCSI) – chuẩn giao tiếp có tốc độ truyền tải dữ liệu nhanh nhất hiện nay, truyền tải dữ liệu theo kiểu nối tiếp.

Trong việc lựa chọn ổ HDD cho server của mình thì ta nên để tâm đến tốc độ đọc/ghi của ổ đĩa (thường được thể hiện qua tốc độ quay của ổ đĩa - rpm càng lớn thì đọc/ghi càng nhanh), chuẩn giao tiếp của ổ cứng, kích thước ổ cứng.

💾 SSD (Solide Sate Drive): là một loại ổ cứng mảy chủ thể rắn. Dữ liệu được lưu trữ trong chip flash, nhờ vậy, dù dữ liệu bị phân mảnh (như trên HDD) thì cũng tốc độ truy xuất dữ liệu cũng không bị ảnh hưởng. Hầu như không có dộ trễ khi người dùng cần truy xuât dữ liệu trong máy.

<img src="https://user-images.githubusercontent.com/79830542/166857642-dbacb905-ebf0-4284-90e0-b29fd8ec72e5.png" width="600">

Công nghệ lưu trữ phổ biến của ổ cứng SSD phổ biến hiện nay: SLC (Single-layer cell), MLC (Multi-layer cell), TLC (Triple-layer cell), QLC (Quad-level cell), PLC (Penta-level cell). Xem chi tiết [tại đây](https://tuanphong.vn/news/cong-nghe-chip-nho-tren-o-cung-ssd-slc-mlc-tlc-qlc-va-plc-la-gi-id198)

### 3.3 So sánh hai loại ổ cứng HDD và SSD

So với ổ cứng HDD truyền thống, ổ cứng SSD server được nghiên cứu và cải thiện rất nhiều nên có khá nhiều tính năng vượt trội hơn HDD:

    - Tốc độ khởi động hệ điều hành

    - Tốc độ ghi chép/ truy xuất dữ liệu

    - Tốc độ hoạt động của các phần mềm

    - Khả năng bảo vệ dữ liệu

    - Khắc phục được tình trạng máy chủ kêu to, hổ trợ tản nhiệt server tốt và hiệu quả hơn
Tuy nhiên, để đạt được hiệu quả cao trong quá trình vận hành cũng như tối ưu về chi phí thì nên sử dụng kết hợp cả 2 loại ổ cứng.

💾 Những thông số quan trọng trên ổ cứng
- Cổng giao tiếp: Có tổng cộng 4 cổng giao tiếp sau: SATA2, SATA3, PCI-Express, USB 3.0. Thông thường ổ cứng có cổng giao tiếp SATA 2 được ưa chuộng nhất vì có thể hỗ trợ nhiều thiết bị nếu bạn muốn phát huy hết hiệu năng của SSD thì nên chọn cổng SATA 3

- Tốc độ đọc/ghi tuần tự tối đa (Max Sequential Read/Writes) hiển thị dưới dạng MB/s ví dụ như 550MB/s hoặc 520 MB/s 

- Tốc độ đọc/ghi ngẫu nhiên (Random Read/Write) là thông số người dùng cần quan tâm khi chọn mua ổ cứng. Tốc độ đọc các file nhỏ của ổ cứng càng cao khi các thông số IPOS lớn hơn.

- Chuẩn bộ nhớ lưu trữ: Các chuẩn công nghệ ổ cứng hiện tại bao gồm QLC, MLC, TLC. Trong đó MLC – Multi level cell là dạng ổ cứng SSD cho laptop cá nhân nên dùng còn các doanh nghiệp nên chọn SLC – Single level cell.

- Khả năng tiết kiệm điện: Ví dụ như các ổ cứng SSD (SATA2, SATA3) có mức tiêu thụ điện năng trung bình khoảng 3W. Dựa vào đây người mua có thể so sánh khả năng tiết kiệm điện của các loại ổ cứng.

- Tính năng đi kèm: Tất cả các ổ cứng SSD hiện nay đều hỗ trợ lệnh TRIM, giúp hệ điều hành chủ động xem xét và xóa bỏ những dữ liệu không còn được dùng. Việc này giúp cho ổ cứng hoạt động mượt mà hơn, tăng tuổi thọ của ổ cứng.

<a name="II.Lab"></a>
# II. Thực hành 🖥️ (lab)

Sử dụng "stress" để test tải hệ thống trên Centos 7. Đây là 1 công cụ ngoài, cần cài đặt thêm nếu muốn sử dụng `yum install -y stress`
 - Đối với CPU, stress sẽ yêu cầu CPU tính căn bậc 2 của một số tự nhiên bất kỳ, tính liên tục cho đến khi có lệnh dừng
 - Đối với RAM, stress sẽ yêu cầu cấp phát bộ nhớ liên tục (dung lượng được cấp phát có thể tuỳ chỉnh)
 - 

Chủ yếu stress dùng để test tải cho CPU và RAM. Xem chi tiết tại đây: 
 - [1. Chạy từng lệnh riêng biệt](https://quantrimang.com/cach-kiem-tra-ap-luc-cua-he-thong-linux-173237)
 - [2.hahahha](https://blog.cloud365.vn/linux/huong-dan-su-dung-stress/)
 - 
Cn đối với disk ta dùng fio: đây cũng là công cụ ngoài cần phải cài đặt thêm. `yum install -y fio`

Câu lệnh để sử dụng fio như sau:
`fio --randrepeat=0 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=vhost --filename=vhost --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75`

Đây là câu lệnh dùng để test IOPS của ổ cứng. Câu lệnh này sẽ tạo ra file 4GB và test theo cơ chế read và write file 4KB đồng thời với tỉ lệ 75%/25% (cứ 3 requests read thì sẽ có 1 request write) với 64 lần thực hiện đồng thời tại một thời điểm. Tỉ lệ 3:1 rất phổ biến với các dạng database ngày nay. IOPS được viết tắt bởi cụm từ Input – output operation per second được hiểu nôm na là 1 truy cập đọc và viết với mỗi giây. Đối với các thiết bị lưu trữ file thì băng thông chính là thông số quan trọng nhất. 
chi tiết [tại đây](https://vhost.vn/lam-the-nao-kiem-tra-hieu-suat-cua-o-cung/)

Một số câu lệnh thao tác với hệ thống

[dmidecode](https://ubunlog.com/vi/verifica-la-ram-instalada-ubuntu/)

[Kiểm tra phần cứng](https://wiki.ngoisaoso.vn/dich-vu-mang/Linux-Huong-dan-kiem-tra-cau-hinh-may-chu-192.html)

[Kiểm tra phần cứng 2](https://thuthuat.taimienphi.vn/kiem-tra-cau-hinh-may-tinh-linux-45645n.aspx)

<a name="tailieu"></a>
# Tài liệu tham khảo 🔖
[1. CPU máy tính](https://stream-hub.com/cpu-may-tinh/)

[2. Tìm hiểu các thông số về CPU](https://genk.vn/tim-hieu-cac-thong-so-co-ban-cua-cpu-20101020113310121.chn)

[3. Core và Thread](https://fptshop.com.vn/tin-tuc/danh-gia/core-va-thread-la-gi-139997)

[4. Các loại RAM ECC](https://quantrimang.com/tim-hieu-ve-cac-loai-ram-server-159508#mcetoc_1epi25tik2)

[5. RAM ECC là gì](https://lagihitech.vn/ram-ecc-la-gi-co-cac-loai-nao/#:~:text=%2DRAM%20ECC%3A%20l%C3%A0%20thanh%20RAM,c%C3%B2n%20cao%20h%C6%A1n%20nhi%E1%BB%81u%20l%E1%BA%A7n.)

