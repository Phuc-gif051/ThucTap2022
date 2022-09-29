## <a name="1" >1. Tổng quan</a>

Web server là máy chủ cài đặt các chương trình phục vụ các ứng dụng web. Web server có khả năng tiếp nhận yêu cầu (request) từ các trình duyệt web của client và gửi phản hồi (reponsive) đến client thông qua giao thức HTTP hoặc các giao thức khác. Có nhiều các ứng dụng web server khác nhau như: Apache, Nginx, IIS,… 

Web server là máy chủ có dung lượng lớn, tốc độ xử lý cũng như truyền tải cao. Tất cả các web server đều có một địa chỉ IP (IP Address) hoặc có một domain name. Ví dụ, khi bạn gõ: https://viettelidc.com.vn vào thanh trình duyệt và gõ phím Enter, tức là bạn đang gửi yêu cầu truy cập đến trang web có domain name là www.viettelidc.com.vn. Khi đó, máy chủ web này sẽ tìm đến website có tên mà bạn muốn truy cập rồi gửi đến trình duyệt của bạn.

Bất kỳ máy tính nào cũng có thể trở thành web server khi bạn cài đặt phần mềm server software và kết nối đến internet. Khi máy tính kết nối đến web server và gửi yêu cầu truy cập đến một trang web bất kỳ, phần mềm web server sẽ nhận yêu cầu và gửi lại kết quả mà bạn đã yêu cầu. Cũng giống như các phần mềm khác, web server software là một ứng dụng phần mềm, nó được cài đặt và chạy trên máy tính dùng làm web server, thông qua các phần mềm này người sử dụng có thể truy cập đến các trang web từ một máy tính khác, thông qua mạng internet, intranet.

Phần mềm web server còn có thể tích hợp với cơ sở dữ liệu, điều khiển việc kết nối vào CSDL để truy cập và kết xuất thông tin từ cơ sở dữ liệu lên website và truyền tải chúng đến người dùng. 

Web server phải đảm bảo hoạt động liên tục 24/7. Bởi vậy máy chủ web phải được đặt tại nơi đảm bảo về chất lượng, tốc độ...để đảm bảo thông tin đến khách hàng luôn được ổn định, thông suốt. 

## <a name="2" >2. Cách hoạt động cơ bản</a>

Khi bạn thực hiện truy cập vào một website ở môi trường internet, đồng nghĩa với việc bạn đang yêu cầu trang đó từ một web server. Dưới đây là 4 bước cơ bản khi ta truy cập đến 1 trang web nào đó:

**B1:** Đầu tiên trình duyệt mà bạn đang dùng sẽ tiến hành xác định địa chỉ IP mà tên miền bạn vừa nhập trỏ về. Nếu trong bộ nhớ cache không chứa sẵn thông tin này, thông qua internet trình duyệt gửi yêu cầu phân giải tên miền đến một hoặc là nhiều máy chủ DNS. Máy chủ DNS thông báo cho trình duyệt biết địa chỉ IP nào mà tên miền sẽ trỏ đến. 

**B2:** Nhận được địa chỉ IP của trang web, trình duyệt sẽ gửi yêu cầu của người dùng đến địa chỉ IP đó thông qua giao thức http (https)

**B3:** Địa chỉ IP đó dẫn tới 1 web server - nơi lưu trữ mã nguồn của trang web, máy chủ web sẽ tiến hành xử lý yêu cầu đã nhận, gửi lại kết quả cho trình duyệt đã gửi yêu cầu thông qua http (https)

**B4:** Trình duyệt nhận được kết quả từ web server, tiến hành giải mã và hiển thị cho người dùng.

Một máy chủ web giao tiếp với trình duyệt web bằng Hypertext Transfer Protocol (HTTP). Nội dung của hầu hết các trang web được mã hóa bằng Hypertext Markup Language (HTML). Nội dung có thể là static (ví dụ: văn bản, hình ảnh,..), hoặc dynamic (giá được tính toán hoặc danh sách các mặt hàng mà khách hàng đã đánh dấu để mua).

Để cung cấp nội dung dynamic. Hầu hết các web server đều hỗ trợ các ngôn ngữ kịch bản, để mã hóa các logic nghiệp vụ vào trong giao tiếp. Các ngôn ngữ được hỗ trợ phổ biến bao gồm Active Server Pages (ASP), Javascript, PHP, Python và Ruby.

### <a name="2.1" >2.1 Giao tiếp thông qua HTTP</a>
HTTP là gì? HTTP (Hypertext Transfer Protocol) - giao thức truyền phát siêu văn bản, một giao thức sẽ là tập hợp các quy tắc để kết nối giữa hai máy tính. Cụ thể HTTP là một giao thức Textual và Stateless.







