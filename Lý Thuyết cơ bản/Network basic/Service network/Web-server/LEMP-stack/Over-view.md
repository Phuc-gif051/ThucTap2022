## <a name="" >Nội dung chính</a>

[1. LEMP stack là gì?](#1)

[2. Phân biệt LEMP-LAMP](#2)

[Tài liệu tham khảo](#3)

___

## <a name="1" >1. LEMP stack là gì?</a>

<p align="center">
    <img src="../../Images/lemp-stack.png" width="750">
</p>

LEMP là một nhóm các phần mềm nguồn mở được cài đặt cùng nhau (tương tự như LAMP) để cho phép máy chủ lưu trữ, vận hành, quản lý,...các trang web động và ứng dụng web. Thuật ngữ này là một loạt các từ viết tắt đại diện cho:

- L: hệ điều hành Linux.
- E: máy chủ web Nginx.
- M: máy chủ cơ sở dữ liệu MariaDB hoặc MySQL.
- P: nội dung động được xử lý bởi PHP.

Khi một máy chủ được cài LEMP thì nó đã được xác định là chỉ dành cho việc phụ vụ web/ứng dụng web.

## <a name="2" >2. Phân biệt LEMP-LAMP</a>

Thật ra giữa 2 nhóm này không có quá nhiều khác biệt. Điều khác biệt lớn nhất là:

- LEMP: sử dụng Nginx để làm web server.
- LAMP: sử dụng Apache để làn web server.

Với Apache thì:

- Apache đã được sử dụng từ lâu (từ những năm 1995), có rất nhiều các module được viết và cả người dùng tham gia vào mở rộng hệ chức năng cho Apache.

- Phương pháp process/thread-oriented – sẽ bắt đầu chậm lại khi xuất hiện tải nặng, cần tạo ra các quy trình mới dẫn đến tiêu thụ nhiều RAM hơn, bên cạnh đó, cũng tạo ra các thread mới cạnh tranh các tài nguyên CPU và RAM.

- Giới hạn phải được thiết lập để đảm bảo rằng tài nguyên không bị quá tải, khi đạt đến giới hạn, các kết nối bổ sung sẽ bị từ chối.

- Yếu tố hạn chế trong điều chỉnh Apache: bộ nhớ và thế vị cho các dead-locked threads cạnh tranh cho cùng một CPU và bộ nhớ.

Với Nginx thì:

- Ứng dụng web server mã nguồn mở được viết để giải quyết các vấn đề về hiệu suất và khả năng mở rộng có liên quan đến Apache.

- Phương pháp Event-driven, không đồng bộ và không bị chặn, không tạo các process mới cho mỗi request từ web.

- Đặt số lượng cho các worker process và mỗi worker có thể xử lý hàng nghìn kết nối đồng thời

- Các module sẽ được chèn vào trong thời gian biên dịch, có trình biên dịch mã PHP bên trong (không cần đến module PHP).

Để kết luận thì nginx nhanh hơn và có khả năng xử lý tải cao hơn nhiều so với Apache khi sử dụng cùng một bộ phần cứng. Tuy nhiên, Apache vẫn là tốt hơn nhiều khi nói đến chức năng và tính sẵn sàng của các module cần thiết để làm việc với các ứng dụng máy chủ back-end và chạy các ngôn ngữ kịch bản lệnh. Vậy nên việc lựa chọn sẽ phụ thuộc phần lớn vào những gì bạn muốn chạy trên web server của mình. Việc chạy cả Apache và nginx trên cùng một máy chủ vẫn có khả năng thực hiện được, và nó sẽ giúp người dùng có được lợi ích tốt nhất từ cả 2 phương pháp. Ví dụ, bạn có thể chạy nginx như reverse proxy trong khi để Apache chạy trong back-end.

## <a name="3" >Tài liệu tham khảo</a>


<https://kblinux.com/cai-dat-lemp-stack-toan-tap-tren-centos-7/#LEMP_la_gi>

<https://bizflycloud.vn/tin-tuc/tong-quan-ve-lamp-lemp-stack-phan-biet-va-huong-dan-cai-dat-tren-server-20180820105455562.htm>
