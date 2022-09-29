## <a name="1" >1. Tổng quan</a>

Web server là máy chủ cài đặt các chương trình phục vụ các ứng dụng web. Web server có khả năng tiếp nhận yêu cầu (request) từ các trình duyệt web của client và gửi phản hồi (reponsive) đến client thông qua giao thức HTTP hoặc các giao thức khác. Có nhiều các ứng dụng web server khác nhau như: Apache, Nginx, IIS,… 

Web server là máy chủ có dung lượng lớn, tốc độ xử lý cũng như truyền tải cao. Tất cả các web server đều có một địa chỉ IP (IP Address) hoặc có một domain name. Ví dụ, khi bạn gõ: https://viettelidc.com.vn vào thanh trình duyệt và gõ phím Enter, tức là bạn đang gửi yêu cầu truy cập đến trang web có domain name là www.viettelidc.com.vn. Khi đó, máy chủ web này sẽ tìm đến website có tên mà bạn muốn truy cập rồi gửi đến trình duyệt của bạn.

Bất kỳ máy tính nào cũng có thể trở thành web server khi bạn cài đặt phần mềm server software và kết nối đến internet. Khi máy tính kết nối đến web server và gửi yêu cầu truy cập đến một trang web bất kỳ, phần mềm web server sẽ nhận yêu cầu và gửi lại kết quả mà bạn đã yêu cầu. Cũng giống như các phần mềm khác, web server software là một ứng dụng phần mềm, nó được cài đặt và chạy trên máy tính dùng làm web server, thông qua các phần mềm này người sử dụng có thể truy cập đến các trang web từ một máy tính khác, thông qua mạng internet, intranet.

Phần mềm web server còn có thể tích hợp với cơ sở dữ liệu, điều khiển việc kết nối vào CSDL để truy cập và kết xuất thông tin từ cơ sở dữ liệu lên website và truyền tải chúng đến người dùng. 

Web server phải đảm bảo hoạt động liên tục 24/7. Bởi vậy máy chủ web phải được đặt tại nơi đảm bảo về chất lượng, tốc độ...để đảm bảo thông tin đến khách hàng luôn được ổn định, thông suốt. 

## <a name="2" >2. Cách hoạt động cơ bản</a>

Khi bạn thực hiện truy cập vào một website ở môi trường internet, đồng nghĩa với việc bạn đang yêu cầu trang đó từ một web server. Dưới đây là 4 bước cơ bản khi ta truy cập đến 1 trang web nào đó:

  - **B1:** Đầu tiên trình duyệt mà bạn đang dùng sẽ tiến hành xác định địa chỉ IP mà tên miền bạn vừa nhập trỏ về. Nếu trong bộ nhớ cache không chứa sẵn thông tin này, thông qua internet trình duyệt gửi yêu cầu phân giải tên miền đến một hoặc là nhiều máy chủ DNS. Máy chủ DNS thông báo cho trình duyệt biết địa chỉ IP nào mà tên miền sẽ trỏ đến. 

  - **B2:** Nhận được địa chỉ IP của trang web, trình duyệt sẽ gửi yêu cầu của người dùng đến địa chỉ IP đó thông qua giao thức http (https)

  - **B3:** Địa chỉ IP đó dẫn tới 1 web server - nơi lưu trữ mã nguồn của trang web, máy chủ web sẽ tiến hành xử lý yêu cầu đã nhận, gửi lại kết quả cho trình duyệt đã gửi yêu cầu thông qua http (https)

  - **B4:** Trình duyệt nhận được kết quả từ web server, tiến hành giải mã và hiển thị cho người dùng.

Một máy chủ web giao tiếp với trình duyệt web bằng [Hypertext Transfer Protocol (HTTP)](https://vietnix.vn/http-la-gi/). Nội dung của hầu hết các trang web được mã hóa bằng [Hypertext Markup Language (HTML)](https://vietnix.vn/html-la-gi/). Nội dung có thể là static (ví dụ: văn bản, hình ảnh,..), hoặc dynamic (giá được tính toán hoặc danh sách các mặt hàng mà khách hàng đã đánh dấu để mua).

Để cung cấp nội dung dynamic. Hầu hết các web server đều hỗ trợ các ngôn ngữ kịch bản, để mã hóa các logic nghiệp vụ vào trong giao tiếp. Các ngôn ngữ được hỗ trợ phổ biến bao gồm Active Server Pages (ASP), Javascript, PHP, Python và Ruby...

## <a name="3" >3. Các yêu cầu để trở thành 1 web server</a>

_**Về phần cứng**_

Các máy chủ web sẽ phải lưu trữ các file của trang web đó bao gồm tất cả các file HTML và các file liên quan như css và javascript, fonts cùng những hình ảnh, video…
Vì thế để trở thành 1 máy chủ web thì phần cứng phải đáp ứng tốt 1 vài điều kiện sau:
  - Tốc độ tiếp nhận và xử lý các yêu cầu tốt.
  - Vận hành liên tục, ổn định, hoạt động tốt 24/7.
  - Đảm bảo kết nối internet ổn định.
  - Có một địa chỉ IP xác định. 
  - Có thể mở rộng hoặc thu nhỏ cấu hình một cách linh hoạt.
  - Được hỗ trợ kỹ thuật từ một bên dịch vụ thứ 3. 

_**Về phần mềm**_

Hiện tại trên thị trường có 3 phần mềm thông dụng nhất cho web server: Apache, NGINX, IIS.

- _Apache HTTP server_

Apache là web server được sử dụng rộng rãi nhất thế giới. Apache được phát triển và duy trì bởi một cộng đồng mã nguồn mở dưới sự bảo trợ của Apache Software Foundation. Apache được phát hành với giấy phép Apache License là được sử dụng tự do, miễn phí.

Tính đến tháng 8 năm 2018, Apache ước tính phục vụ cho 54.2% các trang web đang hoạt động và 53.3% số máy chủ hàng đầu. Apache chạy trên các hệ điều hành như windows, linux, unix, MacOS…

- _Nginx_

Nginx (có thể viết là NGINX hoặc nginx, phát âm tương tự như cụm từ Engine X) là một phần mềm máy chủ web có nhiều tính năng như cân bằng tải, bộ đệm (cache) HTTP hay đóng vai trò là proxy ngược, proxy mail. Igor Sysoev là cha đẻ của phần mềm Nginx và lần đầu Nginx được xuất hiện với thế giới là năm 2004. Công ty cùng tên cũng được thành lập năm 2011 để hỗ trợ và cung cấp phần mềm trả tiền Nginx plus.

Nginx là phần mềm mã nguồn mở và miễn phí, được phát hành rộng rãi theo giấy phép BSD. Nginx được phát triển bằng ngôn ngữ C và chạy được trên các hệ điều hành như Linux, FreeBSD, Windows, MacOS…

- _IIS_

IIS (từ viết tắt của cụm từ Internet Information Services) là một phần mềm máy chủ web do Microsoft tạo lập và phát triển để sử dụng trên các hệ điều hành Windows. IIS hỗ trợ HTTP, HTTP/2, HTTPS, FTP, FTPS, SMTP và NNTP.

Có thể nói IIS là một phần mềm máy chủ lâu đời nhất, ra đời phiên bản đầu tiên vào ngày 30 tháng 05 năm 1999. IIS được viết bằng C++ và hoạt động trên các phiên bản hệ điều hành Windows NT. IIS có cùng dạng bản quyền với bản quyền của Windows NT và phiên bản mới nhất là IIS 10.0.x.x.

Nếu là tín đồ của Windows thì có lẽ chúng ta cũng không lạ lẫm gì với IIS. IIS có thể được cài đặt trực tiếp ở các phiên bản hệ điều hành Windows như Windows XP, Windows 7, Windows 8, và Windows 10. Thông thường IIS hỗ trợ tốt nhất cho các ứng dụng Web ASP.NET, tuy nhiên bạn có thể dùng IIS để thực hiện các ứng dụng Web bằng PHP và các ngôn ngữ Web khác.

>Phần mềm máy chủ đóng vai trò không nhỏ với hiệu suất thực thi của các ứng dụng Web cũng như cung cấp nhiều tính năng đa dạng giúp website đáp ứng nhiều nhu cầu sử dụng khác nhau. Vì vậy, nếu là một nhà quản trị web, bạn cũng nên cân nhắc lựa chọn phần mềm máy chủ bên cạnh các yếu tố về thiết bị phần mềm, công nghệ phát triển web để ứng dụng web có thể chạy tốt nhất có thể.






