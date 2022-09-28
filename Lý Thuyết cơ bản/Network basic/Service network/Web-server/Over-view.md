## <a name="I" >I. Định nghĩa</a>

Web server là máy chủ cài đặt các chương trình phục vụ các ứng dụng web. Webserver có khả năng tiếp nhận yêu cầu (request) từ các trình duyệt web của client và gửi phản hồi (reponsive) đến client thông qua giao thức HTTP hoặc các giao thức khác. Có nhiều các ứng dụng web server khác nhau như: Apache, Nginx, IIS,… 

Web server là máy chủ có dung lượng lớn, tốc độ xử lý cũng như truyền tải cao. Tất cả các web server đều có một địa chỉ IP (IP Address) hoặc có một domain name. Ví dụ, khi bạn gõ: https://viettelidc.com.vn vào thanh trình duyệt và gõ phím Enter, tức là bạn đang gửi yêu cầu truy cập đến trang web có domain name là www.viettelidc.com.vn. Khi đó, máy chủ web này sẽ tìm đến website có tên mà bạn muốn truy cập rồi gửi đến trình duyệt của bạn.

Bất kỳ máy tính nào cũng có thể trở thành web server khi bạn cài đặt phần mềm server software và kết nối đến internet. Khi máy tính kết nối đến web server và gửi yêu cầu truy cập đến một trang web bất kỳ, phần mềm web server sẽ nhận yêu cầu và gửi lại kết quả mà bạn đã yêu cầu. Cũng giống như các phần mềm khác, web server software là một ứng dụng phần mềm, nó được cài đặt và chạy trên máy tính dùng làm web server, thông qua các phần mềm này người sử dụng có thể truy cập đến các trang web từ một máy tính khác, thông qua mạng internet, intranet.

Phần mềm web server còn có thể tích hợp với cơ sở dữ liệu, điều khiển việc kết nối vào CSDL để truy cập và kết xuất thông tin từ cơ sở dữ liệu lên website và truyền tải chúng đến người dùng. 

Web server phải đảm bảo hoạt động liên tục 24/7. Bởi vậy máy chủ web phải được đặt tại nơi đảm bảo về chất lượng, tốc độ...để đảm bảo thông tin đến khách hàng luôn được ổn định, thông suốt. 

## <a name="II" >II. Các hoạt động cơ bản</a>

Một máy chủ web giao tiếp với trình duyệt web bằng Hypertext Transfer Protocol (HTTP). Nội dung của hầu hết các trang web được mã hóa bằng Hypertext Markup Language (HTML). Nội dung có thể là static (ví dụ: văn bản, hình ảnh,..), hoặc dynamic (giá được tính toán hoặc danh sách các mặt hàng mà khách hàng đã đánh dấu để mua).

Để cung cấp nội dung dynamic. Hầu hết các web server đều hỗ trợ các ngôn ngữ kịch bản phía máy chủ để mã hóa logic nghiệp vụ vào giao tiếp. Các ngôn ngữ được hỗ trợ phổ biến bao gồm Active Server Pages (ASP), Javascript, PHP, Python và Ruby.

Khi bạn thực hiện truy cập vào một website ở môi trường internet, đồng nghĩa với việc bạn đang yêu cầu trang đó từ một web server. Ví dụ như bạn nhập đường link sau: https://viettelidc.com.vn ở trình duyệt của mình. Lúc này web server sẽ nhận được yêu cầu từ trình duyệt của bạn và web server sẽ phản hồi lại nội dung của trang. Dưới đây là 4 cách thức hoạt động của web server:

### <a name="II.1" >1. Trình duyệt web phân giải tên miền thành địa chỉ IP</a>



