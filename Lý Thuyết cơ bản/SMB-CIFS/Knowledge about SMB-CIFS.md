# Menu 
___
# <a name="I" >I. SMB-CIFS là gì?</a>
SMB là một giao thức chia sẻ file khá phổ biến khi bạn dùng Windows. Gần như mặc định khi dùng các nền tảng Windows 7/8/10 khi chia sẻ file thì bạn sẽ đụng đến giao thức này. Thế nhưng vẫn còn không ít người cảm thấy xa lạ với thuật ngữ này. Vậy hôm nay hãy tìm hiểu xem SMB-CIFS là gì và sự tiện ích của nó nhé.
## <a name="I.1" >1. Lịch sử hình thành và phát triển</a>
1984 IBM đưa ra SMB trong một bản công bố tài liệu kỹ thuật của mình, thiết kế với mục đích ban đầu là thiết kế một giao thức mạng để đặt tên và duyệt. Về sau SMB được kế thừa bởi Microsoft và trở thành một giao thức chia sẻ file phổ biến trong các phiên bản hệ điều hành của Microsoft và IBM. Hiện tại Microsoft đặt lại tên cho SMB là CIFS (Common Internet File Sharing) hệ thống chia sẻ file phổ biến trên Internet. CIFS thiết kế với tiêu chí đơn giản và khả năng đáp ứng số lượng lớn người dùng. Sự phổ biến của CIFS là do nó phù hợp với mô hình một server tập trung, mọi dữ liệu được xử lý từ client đều được khuyến nghị là lưu trữ tại server.

Cũng tương tự như mục đích ra đời của NFS là dùng để chia sẻ tài nguyên. Thì SMB/CIFS cũng thế, và nó có một vài cải tiến như: hỗ trợ UNICODE, hỗ trợ in qua mạng, tự thiết lập kết nối cho phù hợp giữa server-client...

Microsoft sử dụng SMB cùng với giao thức xác thực NTLM để cung cấp dịch vụ gọi là: chia sẻ file và máy in ở mức user. Khi một user đã đăng nhập thực hiện kết nối tới tài nguyên chia sẻ trên máy tính khác, windows sẽ tự động gửi thông tin đăng nhập của user đó tới SMB server trước khi hỏi username hoặc password.

Trong mô hình mạng OSI, SMB thường được coi là giao thức ở tầng Application (L7) hoặc Presentation (L6), được truyền tải (transport) dựa trên các giao thức cấp thấp hơn. Giao thức truyền tải (L4) mà SMB thường dùng trước đây là NetBEUI và hiện nay là NBT hoặc NetBT. Tuy vậy, giao thức SMB cũng có thể sử dụng không cần một giao thức truyền tải xác định bổ trợ riêng bằng cách kết hợp SMB với NBT để đảm bảo tính tương thích giữa nhiều phiên bản Windows khác nhau. Giao thức SMB trên Windows buộc phải sử dụng truyền tải qua NetBT với các cổng 137, 138 (UDP), 139 (TCP). Từ Windows 2000/XP, Microsoft cấp thêm khả năng chạy SMB trực tiếp trên TCP/IP, chỉ sử dụng cổng 445 (TCP).

![image](https://user-images.githubusercontent.com/79830542/178186439-d23be3f3-d378-44c0-8766-7eeee9ed45f7.png)

## <a name="I.2" >2. Giao thức SMB hoạt động như thế nào?</a>
SMB là giao thức hoạt động theo cơ chế máy khách – máy chủ (request – response). Hiểu đơn giản hơn thì các máy khách sẽ gửi những yêu cầu đến máy chủ SMB sau đó máy chủ sẽ gửi phản hồi lại đến từng yêu cầu.

Trong lần giao tiếp đầu tiên, máy khách sẽ gửi danh sách các bản giao thức khả dụng đến máy chủ, máy chủ sẽ lựa chọn một giao thức phù hợp để sử dụng về sau. Nếu trong danh sách không có giao thức phù hợp thì máy chủ sẽ từ chối.

Khi giao thức được xác nhận, máy khách bắt đầu gửi các yêu cầu để máy chủ phản hồi lại kèm theo các thông tin cần thiết.

Ví dụ như: máy khách yêu cầu đăng nhập vào hệ thống với tên đăng nhập và mật khẩu bất kỳ. Nếu yêu cầu đăng nhập thành công, máy chủ sẽ gửi về một số ID để khách có thể yêu cầu kết nối dữ liệu thông qua chúng.

Máy chủ và máy khách khi sử dụng SMB sẽ duy trì một số thứ tự đồng bộ để phục vụ cho việc tạo mã xác thực tin nhắn, phòng chống các cuộc tấn công mạng. Mỗi tin nhắn đều có thể xác nhận bởi một MAC nhất định.

Ví dụ: Máy in văn phòng được kết nối với máy tính tại phòng nhân sự, khi bạn muốn in bất kỳ một tài liệu nào đó thì máy tính của bạn sẽ gửi yêu cầu đến máy tính tại phòng nhân sự bằng giao thức SMB. Tiếp sau đó, máy chủ sẽ gửi các phản hồi nêu rõ các dữ liệu đang được in hoặc bị từ chối.

![image](https://user-images.githubusercontent.com/79830542/178186774-b94efefa-4524-46c5-acf9-d87dd86a5726.png)

# <a name="II" >II. Dịch vụ Samba trên Linux</a>
## <a name="II.1" >1. Giới thiệu về Samba</a>
Samba là một dịch vụ chạy trên Linux và nó mô phỏng một hệ thống chia sẻ của Windows. Samba cho phép một hệ thống Linux gia nhập vào “Network neighborhood” và người dùng Windows có thể truy cập tài nguyên trên Linux.

Samba thực hiện được nhờ vào sự mô phỏng giao thức CIFS hay ”Common Internet File System” và giao thức truyền tin SMB hay “Server Message Block”

Nói gọn lại samba là một phần mệ miễn phí chủ yếu sử dụng để chia sẻ file giữa các nền tảng khác nhau như Windows và Linux bằng cách sử dụng giao thức SMB/CIFS.

Samba bao gồm 2 chương trính chính và một số công cụ hỗ trợ. Hai chương trình chính là.

 - smbd : dịch vụ tệp và máy in, xác thực phân quyền truy cập tài nguyên.
 - nmdb : Phân giải tên và thông báo cá dịch vụ ra bên ngoài


Một sô công cụ hỗ trợ samba là.

 - smbclient: có chức năng tương tự NFS, kết nối từ hệ thống unix tới smb share của một hệ thống windows để truyền tệp, gửi tệp.
 - nmblookup: Phân giải tên NetBIOS. để tìm địa chỉ IP tương ứng và các thông tin của máy chạy Windows
 - swat : cho phép cấu hình samba qua giao diện web.

## <a name="II.2" >2. Đang cập nhật</a>

# <a name="III" >III. Lưu ý khi sử dụng SMB/CIFS trên Windows</a>
Nếu bạn vẫn có nhu cầu sử dụng giao thức SMB nhưng vẫn muốn bảo vệ tốt nhất cho hệ thống máy tính của mình, các bạn có thể thực hiện một vài biện pháp sau:

 - Khởi chạy tường lửa hoặc để chế độ Endpoint Protection để bảo vệ port SMB và cập nhật blacklist để ngăn chặn các kết nối từ địa chỉ IP đã tấn công trước đó.
 - Thiết lập VPN để mã hóa và bảo vệ lưu lượng mạng.
 - Sử dụng mạng VLAN riêng với lưu lượng nội bộ.
 - Sử dụng bộ lọc địa chỉ MAC để phát hiện và ngăn chặn những địa chỉ không xác định đang muốn truy cập.
 - Tắt giao thức SMBv1 trên windows.
 - ....

# <a name="IV" >IV. Tài liệu tham khảo</a>
1. [SMB là gì?](https://webdoctor.vn/smb-la-gi-su-tien-ich-cua-smb-lieu-co-phai-la-con-dao-hai-luoi/) 
2. [Samba là gì?](https://news.cloud365.vn/samba-server/)
3. [Giao thức SMB là gì](https://thuannhat.com.vn/giao-thuc-smb-la-gi-cach-ngan-cha%CC%A3n-tan-cong/)
4. [Tài liệu tiếng Anh bản pdf](http://media.server276.com/codefx/CIFS_Explained.pdf)
Date access: 11:00 AM, 11/07/2022
