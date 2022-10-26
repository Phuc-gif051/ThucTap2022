## Nội dung chính


___

## <a name="1" >1. Tổng quan</a>

Bài viết này cung cấp 1 số cách để chuyển hướng yêu cầu từ trình duyệt của người dùng, từ việc sử dụng phương thức HTTP không được bảo mật, sang phương thức HTTPS được bảo mật để truy cập website. Tất nhiên, website của bạn đã được cấp chứng chỉ bảo mật TLS/SSL. Có một vài cách để có bảo mật TLS/SSL cho website, ví dụ như: 
- xin chứng chỉ bảo mật từ bên thứ 3 (SSL miễn phí từ Let’s Encrypt): phù hợp cho môi trường public của các cá nhân, doanh nghiệp vừa và nhỏ, cá nhà phát triển cá nhân.
- tự tạo chứng chỉ bảo mật (a-self-signed-ssl-certificate): phù hợp cho môi trường lab, những người mới bắt đầu tìm hiểu về bảo mật website, hoặc các blog cá nhân, có sự tin tưởng ở người sử dụng cuối.

Trong bài viết này website đã được cấp TLS/SSL bằng việc tự tạo chứng chỉ bảo mật, ta sẽ chuyển hướng các yêu cầu của người dùng đến website đang sử dụng HTTP sang website sử dụng HTTPS.

Ta sẽ sử dụng khối code 30x - khối code liên quan đến việc thay đổi địa chỉ của trang web. Thường thì nó sẽ trả về trong phần header chủ yếu là để thông báo cho trình duyệt hoặc các công cụ tìm kiếm. Cơ bản 1 số thông tin như sau:
 - 301 Redirect (Moved permanently) là một mã trạng thái HTTP ( response code HTTP) để thông báo rằng các trang web hoặc URL đã chuyển hướng vĩnh viễn sang một trang web hoặc URL khác, có nghĩa là tất cả những giá trị của trang web hoặc URL gốc sẽ chuyển hết sang URL mới.
 - 302 Redirect (Moved temporarily) là một mã trạng thái HTTP ( response code HTTP) thể thông báo rằng trang web hoặc URL đã chuyển hướng tạm thời sang địa chỉ mới nhưng vẫn phải dựa trên URL cũ. Vì một lý do nào đó, ví dụ như bảo trì trang web chính.

 - Mã 303 (See Other Location): Mã phản hồi này xuất hiện khi người dùng gửi yêu cầu truy cập cho một vị trí khác. Máy chủ sẽ chuyển yêu cầu truy cập đến vị trí đó.
 - Mã 304 (Not Modified): Mã phản hồi này cho biết không cần truyền lại các tài nguyên được yêu cầu. Đây là một loại chuyển hướng ngầm đến các tài nguyên được lưu trữ
 - Mã 305 (Use proxy): Tài nguyên mà bạn yêu cầu truy cập chỉ có thể truy cập được khi có sử dụng máy chủ proxy.
 - Mã 307 (Temporary Redirect): Mã phản hồi này được xem như gần giống với mã 302, nhưng chuyển hướng 307 thường được dùng trong trường hợp nâng cấp source hoặc trang web gặp sự cố, người dung nên tiếp tục truy cập địa chỉ này trong tương lai.

## <a name="2" >2. Thực hành</a>
### <a name="2.1" >2.1 Chuẩn bị</a>
- 01 máy client: sử dụng windows 10
- 01 máy webserver: sử dụng CentOS 7, đã cài Nginx, và triển khai thành công website với HTTP, đồng thời đã cung cấp chứng chỉ TLS/SSL tự ký cho website.
