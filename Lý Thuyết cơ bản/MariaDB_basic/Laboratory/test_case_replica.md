## Nội dung chính

_Thử nghiệm một vài trường hợp đơn giản có thể xảy ta trong quá trình vận hành replica._

## <a name="1" >I. Các máy bị mất kết nối</a>

### <a name="1.1" >1. Máy master mất kết nối</a>

- Giả lập trường hợp lỗi ở máy master bị mất kết nối nhưng vẫn có dữ liệu ghi vào trong lúc mất kết nối.
- Để tiến hành, đơn giản nhất hãy tắt hoạt động của card mạng tại máy master và tiến hành ghi 1 loạt dữ liệu vào.
- Thực thi ghi dữ liệu bằng 1 script đơn giản:

    ```sh
    for i in {1000..8050}; do
    mysql -uroot -pa -e "use replica_db; INSERT INTO test (id, hoten) VALUES ($i, 'hihihaha');"
    done
    ```

- Chuyển sang máy slave, kiểm tra trạng thái của máy với câu lệnh:

    ```sh
    show slave status\G;
    ```

- Nhận được kết quả như sau:

- <img src="../Images/check_master_down.png" width="">

>Máy slave đang cố kết nối đến máy master.

- Trên máy master, kiểm tra việc ghi data:
- <img src="../Images/check_write_data_master.PNG" width="">
- Dễ dàng nhận thấy tiến trình ghi dữ liệu vào database trên máy master vẫn hoạt động bình thường. Chuyển sang máy slave để kiểm tra.
- <img src="../Images/check_data_slave.PNG" width="">
- Không có bất kỳ dữ liệu vào được ghi trên máy slave dù trên máy master đang được ghi.
- Tiến hành kết nối lại bằng cách kích hoạt lại card mạng của máy master.
- Kiểm tra lại trạng thái kết nối của máy slave:
<img src="../Images/show_slave_status_G.PNG" width="600">
- Kết nối lại thành công, không phát sinh bất kỳ lỗi nào. Kiểm tra lượng data sau khi kết nối
- <img src="../Images/check_write_data_master.PNG" width="">
- Đồng bộ thành công giữa 2 máy. Hệ thống hoạt động ổn định sau khi mất kết nối và được kết nối lại, gần như không bị thất thoát dữ liệu. Ngoài thêm, có thể thử với sửa, xoá, tạo mới.

### <a name="1.2" >2. Máy slave mất kết nối</a>

_Thực hiện tương tự_

- Tắt card mạng ở máy slave. Có thể tắt trước hoặc trong khi chỉnh sửa data trên máy master.
- Tiến hành chỉnh sửa dữ liệu trong database trên máy master.
- Mở lại card mạng và kiểm tra tính toàn vẹn của dữ liệu.

## <a name="2" >II. Chuyển máy slave thành máy master</a>

- Trong trường hợp cần nâng cấp máy slave thành máy master: vì bảo mật, hiệu suất, sự cố ở máy master,...
- Đăng nhập vào máy slave tiến hành chuyển đổi.
- Xoá cấu hình chỉ định làm slave cho máy:

    ```sh
    stop slave;
    reset slave all;
    ```

- Khởi động lại dịch vụ để nhận cấu hình mới:

    ```sh
    systemctl restart mariadb
    ```

- Khai báo cấu hình mới để máy trở thành new master với các bước thực hiện của việc cấu hình 1 master.

- Chỉnh sửa các kết nối cần thiết đến máy master mới để hệ thống có thể hoạt động bình thường.

- Sau khi hệ thống mới hoạt động bình thường, nếu sử dụng máy master cũ ta cần dump database từ new master về old master và cấu hình lại các máy trong hệ thống.

## <a name="3" >III. Máy master bị lỗi</a>

- Trường hợp máy master bị lỗi, gây mất mát, hỏng dữ liệu. Đồng thời các lỗi đó cũng được truyền đến các máy slave gây ra hỏng dữ liệu cho toàn hệ thống.
- Lúc này ta cần restore lại database mà trước đây đã back-up trên máy master. Cần kiểm tra xem các restore có được áp dụng trên các máy slave để đảm bảo tính toàn vẹn của dữ liệu hay không.

**Tiến hành thử nghiệm**

- Tạo 1 file backup đơn giản với mysqldump:

    ```sh
    mysqldump -u [user_name] -p [dbname] > [backupfile.sql]
    ```

    Trong đó:
  - [user_name] : tên tài khoản sở hữu database.
  - p : yêu cầu nhập password cho user để xác thực và thực thi câu lệnh.
  - [dbname] : Tên của database.
  - [backupfile.sql] : Tên file backup muốn lưu.

- Tiến hành chỉnh sửa dữ liệu bất kỳ, để giả định trường hợp cần thử nghiệm.
- Chuyển sang máy slave, kiểm tra và nhận thấy dữ liệu được thêm vẫn xuất hiện trong máy slave.
- Tiến hành import lại database để restore database trước khi được thêm dữ liệu.

    ```sh
    mysql -u [user_name] -p [dbname] < [backupfile.sql]
    ```

- Dễ dàng nhận thấy các dữ liệu từ việc back-up đã được ghi lại trên máy master. Chuyển sang máy slave để kiểm tra việc replicate.
- Nếu không có bất kỳ sai sót nào trong quá trình thao tác hay hệ thống mạng lỗi thì ta sẽ nhận thấy database đã restore trên máy master được đồng bộ tại máy slave.

## <a name="0" >Tài liệu tham khảo</a>

<https://news.cloud365.vn/mariadb-replication-cac-test-case-cho-mariadb-master-slave/>
