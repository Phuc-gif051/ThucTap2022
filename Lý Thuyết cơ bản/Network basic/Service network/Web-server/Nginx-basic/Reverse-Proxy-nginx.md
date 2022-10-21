Cùng với Apache, Tomcat, Nginx là một web server phổ biến trên HDH Linux. Nó có một tính năng Reverse Proxy được sử dụng như một chương trình cân bằng tải (Load Balancing). Trong bài viết này, chusng ta se hiểu qua về Reverse Proxy trên Nginx nhé!

## <a name="1" >1. Tổng quan Reverse Proxy</a>

- Reverse Proxy là gì?
Reverse Proxy được hiểu là một proxy server trung gian giữa Client (máy khách) và Server (máy chủ). Mội yêu cầu (request) từ client tới máy chủ và ngược lại phản hồi (reponse) từ máy chủ về client đều bắt buộc phải đi qua proxy server. Vì vậy máy chủ hoàn toàn được ẩn danh trước Client. Các client chỉ có thể biết được thông tin của Proxy Server.

https://vinasupport.com/uploads/2021/09/Nginx-Reverse-Proxy-Architect.png

- Tại sao cần sử dụng Reverse Proxy?
  
   + Chạy được nhiều loại ứng dụng một lúc trên Server: Reverse Proxy có thể điều hướng nhiều request tới các ứng dụng riêng lẻ. Bạn có thể chạy ứng dụng A trên cổng 80, ứng dụng B trên cổng 81. Bằng cách cấu hình proxy_pass cho server.
   + Cân bằng tải (Load Balancing): Nếu bạn có nhiều máy chủ chạy ứng dụng thì bạn có thể sử dụng, để phân tải bằng việc điều hướng các request từ client tới các server khác nhau.
   + Tường lửa và ẩn danh: Vì là một proxy server nên nó có thể lọc các request nhanh chóng, đồng thời che giấu địa chỉ IP của máy chủ.

## <a name="2" >2. Cấu hình Reverse Proxy trên Nginx</a>
### <a name="2.1" >2.1 Mô hình triển khai</a>



https://vinasupport.com/cau-hinh-reverse-proxy-proxy_pass-tren-nginx/