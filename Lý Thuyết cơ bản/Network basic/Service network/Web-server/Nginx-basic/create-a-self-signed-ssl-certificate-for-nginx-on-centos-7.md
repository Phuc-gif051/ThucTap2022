## Nội dung chính
[1. Tổng quan về bảo mật duyệt web](#1)

[2. Tiến hành lab](#2)

 - [Bước 1: tạo chứng chỉ SSL](#2.1)
 - [Bước 2: cấu hình cho web-site muốn áp dụng khoá](#2.2)

[3. Kiểm thử](#3)
___

## <a name="1" >1. Tổng quan về bảo mật duyệt web</a>
- SSL là chữ viết tắt của Secure Sockets Layer (Lớp socket bảo mật). Một loại bảo mật giúp mã hóa liên lạc giữa website và trình duyệt. Công nghệ này đang lỗi thời và được thay thế hoàn toàn bở TLS.

- TLS là chữ viết tắt của Transport Layer Security, nó cũng giúp bảo mật thông tin truyền giống như SSL. Nhưng vì SSL không còn được phát triển nữa, nên TLS mới là thuật ngữ đúng nên dùng.

- HTTPS là phần mở rộng bảo mật của HTTP. Website được cài đặt chứng chỉ SSL/TLS có thể sử dụng giao thức HTTPS để thiết lập kênh kết nối an toàn tới server.

- Trong bài thực hành này sử dụng A self-signed certificate: là 1 cách cấp bảo mật cho trang web mà độ tin cậy hoàn toàn đến từ phía người cung cấp và người sử dụng, không có bât kỳ sự chứng thực đến từ một bên thứ 3 nào. Vì thế chỉ phù hợp cho môi trường lab hoặc các hệ thống nhỏ đã được tin tưởng từ 2 phía.

_lưu ý: nên tiến hành lab với người dùng có quyền `sudo` chứ không phải người dùng `root`_


## <a name="2" >2. Tiến hành lab</a>

### <a name="2.1" >Bước 1: tạo chứng chỉ SSL</a>

- TLS/SSL hoạt động bảo mật và xác thực bởi 2 khoá chính: khoá công khai vào khoá riêng tư. Thường thì khoá công sẽ được tạo ra và lưu trữ tại `/etc/ssl/certs`. Bây giờ ta sẽ tạo ra khoá riêng tư.

- Tạo nơi lưu trữ khoá riêng tư và thay đổi quyền đọc ghi của thư mục:

```sh
sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private
```

- Tạo ra khoá bằng câu lệnh sau:

```sh
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```

- Trong đó:

	- openssl : Đây là công cụ dòng lệnh cơ bản để tạo và quản lý chứng chỉ OpenSSL, khóa và 1 số công cụ bảo mật khác. Khi cài đặt Nginx từ source thì ta sẽ phải tự cài công cụ này.
	- req: khai báo rằng bạn muốn sử dụng X.509 để quản lý và chứng thực cho khoá mà bạn tạo ra. X.509 là tiêu chuẩn mà SSL và TLS tuân thủ để quản lý khoá và chứng chỉ liên quan. Khi tạo mới 1 khoá ta nên áp dụng X.509 này cho khoá.
	- -x509: thông báo rằng bạn sẽ tự sửa đổi 1 số thông tin cơ bản cho khoá đễ tạo ra khoá tự chứng thực. Mặc định hệ thống sẽ tự tạo ra 1 số thông tin đó.
	- -nodes: bỏ qua việc tạo mật khẩu bảo mật cho khoá, thông thường thì OpenSSL sẽ yêu cầu tạo mật khẩu cho khoá mới, và mỗi khi sử dụng đến ta sẽ phải nhập mật khẩu để Nginx có thể truy cập và sử dụng khoá. Đây là lựa chọn bỏ qua việc tạo mật khẩu.
	- -days: khoảng thời gian mà khoá có hiệu lực, tính bằng ngày.
	- -newkey: xác nhận đây là tạo ra khoá mới và cả chứng chỉ mới cùng 1 lúc.
	- rsa: 2048 : sử dụng thuật toán mã hoá RSA, với khoá dài 2048 bit.
	- -keyout : Dòng này cho OpenSSL biết nơi đặt tệp khóa riêng đã tạo mà bạn đang tạo.
	- -out : Điều này cho OpenSSL biết nơi đặt chứng chỉ mà bạn đang tạo.

- Sau khi enter khoá và chứng chỉ mới sẽ được tạo, cùng với đó là 1 số lời nhắc đến từ hệ thống như sau

```sh
Output
Country Name (2 letter code) [XX]:VN
State or Province Name (full name) []:Example
Locality Name (eg, city) [Default City]:Example 
Organization Name (eg, company) [Default Company Ltd]:Example Inc
Organizational Unit Name (eg, section) []:Example Dept
Common Name (eg, your name or your server's hostname) []:your_domain_or_ip
Email Address []:webmaster@example.com
```

Thông tin quan trọng nhất cần nhập chính xác là dòng `Common Name (eg, your name or your server's hostname) []`

- Cả hai tệp bạn đã tạo sẽ được đặt trong các thư mục con thích hợp của thư mục /etc/ssl/certs.

_Gợi ý thêm:_

>Nếu bạn muốn tạo khoá cá nhân và sử dụng trên môi trường internet thì nên tạo thêm 1 lớp bảo mật nữa cho khoá, để tránh bị xâm phạm.
>sử dụng câu lênh `sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048` sẽ mất 1 vài phút để tạo. 
>Một nhóm Diffie-Hellman mạnh mẽ sẽ được tạo ra, được sử dụng để đàm phán [Perfect Forward Secrecy](https://en.wikipedia.org/wiki/Forward_secrecy) với khách hàng
>Nó sẽ được lưu tại `/etc/ssl/certs/dhparam.pem`



### <a name="2.2" >Bước 2: cấu hình cho web-site muốn áp dụng khoá</a>

- Tạo hoặc mở tệp config của website: 

```sh
sudo vi /etc/nginx/conf.d/test.lab.conf
```

- Tiến hành chỉnh sửa, khai báo thêm những điều cơ bản như sau:

```sh
server {
    listen 443 http2 ssl;
    listen [::]:443 http2 ssl;

    server_name [your_server_name_or_ip];

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    # ssl_dhparam /etc/ssl/certs/dhparam.pem;
}
```
- Trong đó:
	- listen: mặc định là port 443, có thể thay đổi theo yêu cầu của bạn.
	- server_name: phải trùng với thông tin bạn đã cung cấp khi tạo khoá. ở đây sẽ là test.lab.
	- ssl_certificate - ssl_certificate_key: nơi lưu trữ khoá và chứng chỉ mà bạn tạo.

- Lưu lại và thoát. Kiểm thử cấu hình `nginx -t`

- Thông thường sẽ có cảnh báo như bên dưới, vì ta đang sử dụng chứng chỉ tự ký cho trang web.
```sh
nginx: [warn] "ssl_stapling" ignored, issuer certificate not found
```

- Nếu không có bất kỳ cảnh báo nào khác tức là đã cài đặt thành công. Khởi động lại dịch vụ:
```sh
sudo systemctl restart nginx
```

## <a name="3" >3. Kiểm thử</a>

- Mở trình duyệt web của bạn và nhập https://tên_miền_hoặc_IP_của_website vào thanh địa chỉ:

```sh
https://website_domain_or_IP
```

Bởi vì chứng chỉ bạn đã tạo không được ký bởi một trong những tổ chức phát hành chứng chỉ đáng tin cậy của trình duyệt của bạn, bạn có thể sẽ thấy một cảnh báo trông như hình dưới đây:

<p align="center">
	<img src="https://user-images.githubusercontent.com/79830542/197441613-6326a684-44cf-4e25-a9cb-ef5a36f87420.png" width="700">
</p>

Điều này được mong đợi và bình thường. Bạn chỉ quan tâm đến khía cạnh mã hóa của chứng chỉ, chứ không phải sự xác nhận của bên thứ ba về tính xác thực của máy chủ của bạn. Nhấp vào `ADVANCED` và sau đó nhấp vào liên kết được cung cấp để tiếp tục với website của bạn:

<p align="center">
	<img src="https://user-images.githubusercontent.com/79830542/197441823-c116eedd-1e49-499b-bf3e-31dd744dadbc.png" width="700">
</p>

Bạn sẽ được đưa đến trang web của bạn. Nếu bạn nhìn vào thanh địa chỉ của trình duyệt, bạn sẽ thấy một số dấu hiệu về bảo mật một phần. Đây có thể là ổ khóa có dấu “x” trên đó hoặc hình tam giác với dấu chấm than. Trong trường hợp này, điều này chỉ có nghĩa là chứng chỉ không thể được xác thực. Nó vẫn đang mã hóa kết nối của bạn.

<p align="center">
	<img src="https://user-images.githubusercontent.com/79830542/197442111-f108d31a-d682-4a1f-b700-245e7b2ea219.png" width="">
</p>

Để có thể chắc chắn hơn, hãy dùng bất kỳ công cụ bắt gói tin nào để kiểm tra. Khuyên dùng: WireShark.

### <a name="4" >Tài liệu tham khảo</a>

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7
