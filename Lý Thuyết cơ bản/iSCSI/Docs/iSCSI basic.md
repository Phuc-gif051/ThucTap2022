# Mục lục
[I. iSCSI là gì❔](#I)

[II. Các thành phần chính 🥧](#II)
 - [1. iSCSI Initiator](#II.1)
 - [2. iSCSI Target](#II.2)

[III. iSCSI hoạt động như thế nào? 👷‍♂️](#III)
___

# <a name="I" >I. iSCSI là gì❔</a>
iSCSI (đọc là: ai-x-kơ-zi) là từ viết tắt của Internet Small Computer Systems Interface. 
iSCSI là một giao thức lớp vận chuyển hoạt động trên giao thức TCP/IP (Transport Control Protocol). 
Nó cho phép truyền dữ liệu SCSI ở block-level giữa iSCSI initiator (client) và iSCSI target (server) trên môi trường mạng thông qua TCP/IP. 
iSCSI hỗ trợ mã hóa các gói mạng và giải mã khi đến đích.

Giao thức này cho phép các quản trị viên khai thác tốt hơn các loại hình lưu trữ được chia sẻ bằng cách cho phép máy chủ 
lưu trữ dữ liệu vào bộ lưu trữ được kết nối qua mạng từ xa và ảo hóa thành phần lưu trữ từ xa cho các ứng dụng yêu cầu lưu trữ trực tiếp.
Khi client được chia sẻ các không gian lưu trữ từ server thì có thể sử dụng nó như một ổ cứng vật lý được thêm vào máy.

Hiểu đơn giản thì iSCSI chính là chuẩn giao tiếp SCSI trên môi trường mạng.

# <a name="II" >II. Các thành phần chính 🥧</a>
Một giao tiếp kết nối iSCSI sẽ bao gồm 2 thành phần chính sau:

 - iSCSI Initator: là client, được chia sẻ tài nguyên lưu trữ
 - iSCSI Target: là server, quản lý và chia sẻ tài nguyên.

<img src="https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/iSCSI/Images/architechture.jpg" width="300">

## <a name="II.1" >1. iSCSI Initiator</a>
iSCSI Initiator (iSCSI Initiator Node) là thiết bị client trong kiến trúc hệ thống lưu trữ qua mạng. iSCSI Initiator sẽ kết nối đến máy chủ iSCSI Target và truyền tải các lệnh SCSI thông qua đường truyền mạng TCP/IP. iSCSI Initiator có thể được khởi chạy từ chương trình phần mềm trên OS hoặc phần cứng thiết bị hỗ trợ iSCSI. Từ windows 7 trở lên thì iSCSI initiator đã được cài đặt sẵn và sẵn sàng sử dụng.

## <a name="II.2" >2. iSCSI Target</a>
iSCSI Target thường sẽ là một máy chủ lưu trữ (server storage) có thể là hệ thống SAN chẳng hạn. Từ máy chủ iSCSI Target sẽ tiếp nhận các request gửi từ iSCSI Initiator gửi đến và gửi trả dữ liệu trở về. Trên iSCSI Target sẽ quản lý các ổ đĩa iSCSI với các tên gọi LUN (Logical Unit Number) được dùng để chia sẻ ổ đĩa lưu trữ iSCSI với phía iSCSI Initiator.

# <a name="III" >III. iSCSI hoạt động như thế nào? 👷‍♂️</a>
 – Máy client sẽ khởi tạo request yêu cầu truy xuất dữ liệu trong hệ thống lưu trữ (storage) ở máy chủ iSCSI Target. Lúc này hệ thống iSCSI Initiator sẽ tạo ra một số lệnh SCSI tương ứng với yêu cầu của client.
 
 – Các lệnh SCSI và thông tin liên quan sẽ được đóng gói trong gói tin iSCSI Protocol Data Unit (iSCSI PDU). Thông tin PDU được sử dụng cho kết nối giữa Initiator và Target với các thông tin nhằm xác định node, kết nối, thiết lập session, truyền tải lệnh iSCSI và truyền tải dữ liệu.
 
 – Sau đó PDU  được đóng gói trong mô hình TCP/IP và truyền tải qua mạng network đến máy chủ iSCSI Target.
 
 – Máy chủ iSCSI Target nhận được gói tin và tiến hành mở gói tin ra kiểm tra phần iSCSI PDU nhằm trích xuất các thông tin lệnh SCSI cùng các nội dung liên quan.
 
 – Sau đó lệnh SCSI sẽ được đưa vào SCSI Controller để thực thi và xử lý theo yêu cầu. Đến cuối cùng iSCSI Target sẽ gửi trả thông tin iSCSI response. Từ đó cho phép block data lưu trữ được truyền tải giữa Inititator và Target.
 

<img src="https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/iSCSI/Images/iscsi-tcp-ip.jpg" width="600">

_Chú ý:_ Các kết nối iSCSI giữa Inititator và Target có thể hoạt động của cùng 1 cuộc giao tiếp giữa Initiator và Target. Một cuộc giao tiếp như vậy sẽ được gọi là một iSCSI Session.

<img src="https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/iSCSI/Images/iscsi-session.png" width="500">


# <a name="4" >Tài liệu tham khảo</a>
1. [ISCSI là gì? Thành phần và cách thức hoạt động của ISCSI](https://bizflycloud.vn/tin-tuc/iscsi-la-gi-20210727181045502.htm)
2. [iSCSI là gì và cách thức hoạt động như thế nào?](https://www.thegioimaychu.vn/blog/tong-hop/iscsi-la-gi-va-cach-thuc-hoat-dong-nhu-the-nao-p2046/)
3. [iSCSI là gì ? Tìm hiểu về hệ thống lưu trữ iSCSI SAN](https://cuongquach.com/iscsi-la-gi-tim-hieu-he-thong-luu-tru-iscsi-san.html)

Date access 14/07/2022 


