## <a name="" >Cài đặt Nginx trên môi trường CentOS 7</a>

## <a name="1" >1. Mô hình triển khai</a>
- Máy 1: CentOS 7
    - Cài đặt nginx để làm Web server.
    - IP: 172.16.5.6/16; 172.16.15.6/24
    - 2 vCPU, 2 GB RAM, 40 GB ROM.

- Máy 2 (có thể có hoặc không): CentOS 7
    - Cài đặt bind-utils để làm DNS server.
    - IP: 172.16.5.5/16; 172.16.15.5/24
    - 2 vCPU, 2 GB RAM, 40 GB ROM.
    - Có thể xem hướng dẫn chi tiết cài đặt và cấu hình DNS server [tại đây](https://vietnetwork.vn/routers-switches/cai-dat-va-cau-hinh-dns-server-tren-centos-7/)

- Máy 3: Windows 10
    - Dùng làm client kết nối đến Web server để tải trang web.
    - IP: 172.16.5.14/16;
    - 2 vCPU, 2 GB RAM, 40 GB ROM.


## <a name="2" >2. Tiến hành cài đặt</a>

Trên máy 2 tiến hành cài đặt và cấu hình Web server với đăng nhập là người dùng `root` hoặc người dùng có quền `sudo`

### <a name="2.1" >2.1 Cài đặt dịch vụ Nginx</a>
- B1: cài đặt nginx `yum install nginx -y`
- B2: Khởi động dịch vụ `systemctl start nginx`
- B3: cấu hình firewall
    - Mở port cho dịch vụ của nginx. Nếu không chỉ định port thì mặc định là 443 và 80 sẽ được sử dụng
    ```sh
    firewall-cmd --permanent --zone=public --add-service=http 
    firewall-cmd --permanent --zone=public --add-service=https
    firewall-cmd --reload
    ```
    - Hoặc tắt firewall:
    ```sh
    systemctl disable firewalld
    ```
 - B4: kiểm tra lại sự hoạt động của dịch vụ `systemctl status nginx`
 - <img src="https://user-images.githubusercontent.com/79830542/192985870-58070f4e-ef99-4509-b432-81887db505ff.png" width="650">
 - Trên máy windows: sử dụng bất kỳ trình duyệt nào, tiến hành truy cập vào máy chủ `http://IP_wed_server` để kiểm tra, nhận được kết quả như hình dưới là thành công khởi động dịch vụ.
 - <img src="https://user-images.githubusercontent.com/79830542/192987270-52b34eaf-c604-47cd-98b1-92b26a247831.png" width="700">

### <a name="2.2" >2.2. Cấu hình cho web site của bạn trên web server</a>
    
 - ⚠️ Trước tiên, để cấu hình được ta cần biết phải cấu hình file nào và chúng nằm ở đâu: ⚠️
>Các file cấu hình:
>- Tất cả các tệp cấu hình Nginx đều nằm trong thư mục /etc/nginx/.
>- Tệp cấu hình chính của Nginx là /etc/nginx/nginx.conf.
>- Để duy trì cấu hình Nginx dễ dàng hơn, bạn nên tạo một tệp cấu hình riêng cho từng miền.
>- Các file cấu hình phải kết thúc bằng .conf và được lưu trữ trong thư mục /etc/nginx/conf.d.
>- Nếu tên miền của bạn là mydomain.com thì tệp cấu hình của bạn phải được đặt tên /etc/nginx/conf.d/mydomain.com.conf
>- Các file log của Nginx (access.log và error.log) nằm trong thư mục /var/log/nginx/.

 - ⏯️ Tiến hành cấu hình: 
    - Trong Nginx thì Virtual Host là file cấu hình cho phép nhiều domain cùng chạy trên một máy chủ. Tất cả các file vhost sẽ nằm trong thư mục /etc/nginx/conf.d/. Để tiện quản lý mỗi website nên có một vhost riêng.
    - Trong ví dụ này sẽ tạo website test.lab với vhost tương ứng là /etc/nginx/conf.d/test.lab.conf
    - Tạo thư mục để chứa mã nguồn website: `mkdir -pv /var/www/test.lab/html`
    - Thay đổi chủ sở hữu cho các thư mục
      ```sh 
      chown –R nginx:nginx /var/www/test.lab
      chmod –R 775 /var/www
      ``` 
    - dùng trình soạn thảo vi để tạo file 1 file html cơ bản như sau: `vi /var/www/test.lab/html/index.html`
      ```sh
      <html>
          <head>
              <title>Server cua toi</title>
          </head>
          <body>
              <h1>Xin chao the gioi</h1>
          </body>
      </html>
      ```
     - tiếp tục sử dụng trình soạn thảo vi để tạo file config và chỉnh sửa: `vi /etc/nginx/conf.d/test.lab.conf`

      ```sh
      server {
          listen 80; # port mặc định sử dụng cho giao thức HTTP
          listen [::]:80;

          root /var/www/test.lab/html; # đường dẫn đến nơi lưu trữ mã nguồn 

          index index.html; # trang html hiển thị cho người dùng

          server_name test.lab www.test.lab; # danh sách các tên miền có thể dùng để truy cập trang web của bạn

          access_log /var/log/nginx/test.lab.access.log; # nơi lưu trữ các yêu cầu tới website của bạn.
          error_log /var/log/nginx/test.lab.error.log; # nơi lưu trữ lỗi.
          
          # nơi đặt các cấu hình (các chỉ thị) cho website. Ví dụ như thêm bớt các header, configure module, reverse proxy,...

          location / {
              try_files $uri $uri/ =404;
          }
      }
      ```
      
      - Cấu hình cơ bản là xong, kiểm tra cấu hình: `nginx -t`
      - ![image](https://user-images.githubusercontent.com/79830542/192998335-ba8bcfbd-10fa-4a32-b81c-472b99167f99.png)
      - Nhận được kết quả như hình trên là thành công
      - Thử kết nối trên máy window. Nếu không cấu hình DNS server thì chỉnh sửa file hosts nằm ở thư mục: `C:\Windows\System32\drivers\etc` dưới quyền administrator:
      - <img src="https://user-images.githubusercontent.com/79830542/192999088-965ddb93-7c64-453e-9627-00b164258a30.png" width="500">
      - Truy cập `http://test.lab`, nhận được trang html đã tạo là thành công.
      - <img src="https://user-images.githubusercontent.com/79830542/193000965-c8238ee5-32a9-4aa3-9950-642e4f6825e8.png" width="650">


### <a name="3" >Tài liệu tham khảo</a>

https://123host.vn/community/tutorial/huong-dan-cai-dat-nginx-tren-centos-7.html#buoc-4-quan-ly-dich-vu-nginx

https://blog.hostvn.net/chia-se/huong-dan-cai-dat-nginx-tren-centos-7.html#4_Cac_file_cau_hinh

https://www.interserver.net/tips/kb/create-manage-virtual-hosts-nginx/

Date acced: 28/09/2022

       
     
