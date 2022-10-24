## Nội dung chính
[1. Tổng quan reverse proxy](#1)

[2. Cấu hình Reverse Proxy trên Nginx](#2)

   - [2.1 Mô hình triển khai](#2.1)
   - [2.2 Triển khai](#2.2)
    
[Tài liệu tham khảo](#3)
___

## <a name="1" >1. Tổng quan Reverse Proxy</a>

Cùng với Apache, Tomcat, Nginx là một web server phổ biến trên HDH Linux. Nó có một tính năng Reverse Proxy được sử dụng như một chương trình cân bằng tải (Load Balancing). Trong bài viết này, chusng ta se hiểu qua về Reverse Proxy trên Nginx nhé!

- Reverse Proxy là gì?
Reverse Proxy được hiểu là một proxy server trung gian giữa Client (máy khách) và Server (máy chủ). Mội yêu cầu (request) từ client tới máy chủ và ngược lại phản hồi (reponse) từ máy chủ về client đều bắt buộc phải đi qua proxy server. Vì vậy máy chủ hoàn toàn được ẩn danh trước Client. Các client chỉ có thể biết được thông tin của Proxy Server.
<p align="center">
   <img src=https://user-images.githubusercontent.com/79830542/197379320-f315542b-23e0-451e-8825-a0b8f508291f.png width=650>
</p>

- Tại sao cần sử dụng Reverse Proxy?
  
   + Chạy được nhiều loại ứng dụng một lúc trên Server: Reverse Proxy có thể điều hướng nhiều request tới các ứng dụng riêng lẻ. Bạn có thể chạy ứng dụng A trên cổng 80, ứng dụng B trên cổng 81. Bằng cách cấu hình proxy_pass cho server.
   + Cân bằng tải (Load Balancing): Nếu bạn có nhiều máy chủ chạy ứng dụng thì bạn có thể sử dụng, để phân tải bằng việc điều hướng các request từ client tới các server khác nhau.
   + Tường lửa và ẩn danh: Vì là một proxy server nên nó có thể lọc các request nhanh chóng, đồng thời che giấu địa chỉ IP của máy chủ và cả IP của người dùng.

## <a name="2" >2. Cấu hình Reverse Proxy trên Nginx</a>
_Đây là cấu hình reverse cơ bản để reverse sang 1 web-server khác_
### <a name="2.1" >2.1 Mô hình triển khai</a>
- Máy client: sử dụng windows 10, có thể khai báo cấu hình tại file host.
- Máy server 1: sử dụng CentOS 7, đã cài đặt Nginx để làm máy reverse.
- Máy server 2: sử dụng CentOS 7, đã cài đặt Nginx để làm máy web server, và cài đặt 1 website cơ bản.
<p align="center">
   <img src="https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/Network%20basic/Service%20network/Images/architecture_proxy_pass.png" width=650 >
</p>

### <a name="2.2">2.2 Triển khai</a>

⏯️
B1: Khai báo 1 file cấu hình mới trên máy reverse. `vi /etc/nginx/conf/pet.lab.conf`
B2: Khai báo cơ bản như sau:

    ```sh
    server {
    listen 172.16.15.6:8080;

    server_name pet.com;
    access_log /var/log/nginx/pet.lab.access.log;
    error_log /var/log/nginx/pet.lab.error.log;
    
         location / {
           
           proxy_pass http://172.16.15.7:8080;
           
           proxy_set_header Host $host;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Real-IP $remote_addr;
         
           proxy_read_timeout 3600s;
           proxy_connect_timeout 300s;
         }
     }
    ```
    
  Trong đó:
  
   - listen: địa chỉ IP:port (hoặc domain name) của server 1.
   - server_name: domain name (hoặc các dạng URL) mà khối server này sẽ tiếp nhận để xử lý.
   - access_log - error_log: nơi lưu trữ lại các lịch sử truy cập và lỗi sinh ra trong quá trình hoạt động của website
   - Khối `location {...}`: nơi sẽ sử lý các yêu cầu được gửi đến website. Trong bài viết này sẽ dùng để chuyển hướng các yêu cầu đến 1 server khác.
   - proxy_pass: địa chỉ IP:PORT (hoặc URL) của website được điều hướng đến.
   - proxy_set_header: Gửi thông tin header từ client cho Server
   - proxy_read_timeout: Thời gian timeout chờ đọc thông tin từ server
   - proxy_connect_timeout: Thời gian timeout chờ kết nối
    
B3: lưu lại và thoát, sử dụng `nginx -t` để kiểm tra cấu hình. Không gặp lỗi thì khởi động lại dịch vụ Nginx

    ```sh
    systemctl restart nginx
    ```
    
B4: trên máy client, đã cấu hình file hosts hoặc sử dụng trình duyệt truy cập vào địa chỉ của máy server 1. Nhận được website đã cài đặt trên máy 2 là thành công.

<p align="center">
   <img src="https://user-images.githubusercontent.com/79830542/197432184-330f6916-5d22-49e7-bc1a-f5a65db63140.png" width="700">
</p>  
 

**Ngoài việc điều hướng đến web site khác, reverse còn có khả năng điều hướng đến các ứng dụng chạy treen nền web**
#### <a name="3">Tài liệu tham khảo</a>

https://vinasupport.com/cau-hinh-reverse-proxy-proxy_pass-tren-nginx/

https://viblo.asia/p/cach-cau-hinh-nginx-thanh-reverse-proxy-aWj53jkQl6m

Date acced: 21/10/2022
