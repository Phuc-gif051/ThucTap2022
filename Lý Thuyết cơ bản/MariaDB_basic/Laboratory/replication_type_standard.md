## Nội dung chinh

_Bài thực hành triển khai MariaDB Standard Replication trên môi trường CentOS 7_


___

## <a name="1" >1. Mở đầu</a>

- Đây là dạng cơ bản nhất của MariaDB replication, cung cấp khả năng đọc vô hạn, dễ dàng chuyển đổi máy slave thành master theo yêu cầu.

<p align="center">
 <img src="../Images/standard_replication.png" width="600">
</p>

- Chuẩn bị:

  - Ít nhất 2 máy, cấu hình tối thiểu: 1 CPU, 1GB RAM, 1 GB ROM.
  - Đã cài đặt CentOS 7, MariaDB 10.x trở lên.
  - User đăng nhập hệ thống có quyền sudo. Tại đây sử dụng tài khoản `root`.

## <a name="2" >2. Tiến hành triển khai</a>

### <a name="2.1" >2.1 Cấu hình trên máy Master</a>

- Khai báo port sẽ sử dụng với firewalld:

    ```sh
    firewall-cmd --add-port=3306/tcp --zone=public --permanent
    ```

- Reload để nhận cấu hình mới

    ```sh
    firewall-cmd --reload
    ```

- Sử dụng trình soạn thảo `vi` truy cập và chỉnh sửa file config:

    ```sh
    vi /etc/my.cnf
    ```

- Trong file config khai báo như sau tại khối `[mariadb]`:

    ```sh
    [mariadb]
    server-id=1
    log-bin=master
    binlog-format=row
    binlog-do-db=replica_db
    ```

  - Trong đó:

    - server_id là tùy chọn được sử dụng trong replication cho phép master server và slave server có thể nhận dạng lẫn nhau. Server_id với mỗi server là khác nhau, nhận giá trị từ 1 đến 4294967295 (mariadb >=10.2.2) và 0 đến 4294967295 (mariadb =<10.2.1)
    - log-bin hay log-basename là tên cơ sở để tạo tên tệp nhật ký nhị phân. Các tệp binary log sẽ có tên bắt đầu như thế.
    - binlog-format là định dạng dữ liệu được lưu trong file bin log.
    - binlog-do-db là tùy chọn để nhận biết cơ sở dữ liệu nào sẽ được replication. Nếu muốn replication nhiều CSDL, bạn phải viết lại tùy chọn binlog-do-db nhiều lần. Hiện tại không có option cho phép chọn toàn bộ CSDL để replica mà bạn phải ghi tất cả CSDL muốn replica ra theo option này.

- Restart lại dịch vụ để nhận cấu hình mới:

    ```sh
    systemctl restart mariadb
    ```

- Tiến hành đăng nhập vào Mariadb để tạo database và user mới:

    ```sh
    mysql -u root -p
    ```

    >Đăng nhập vào mariadb

    ```sh
    create database replica_db;
    ```

    >Tạo database mới

  - Tạo user mới và gán quyền cho user đó:

    ```sh
    create user 'slave_user'@'%' identified by 'abc@123';
    ```

    >Tạo user mới

    ```sh
    GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'abc@123';
    ```

    >Gán quyền cho user

  - Xác nhận lại các thay đổi:

    ```sh
    FLUSH PRIVILEGES;
    ```

- Để có thể tiến hành replica với hạn chế tối đa việc sai lệch dữ liệu, ta cần tạm dừng tất cả các hành động ảnh hưởng đến database trên máy master:

    ```sh
    FLUSH TABLES WITH READ LOCK;
    ```

- Thoát khỏi Mariadb, tiến hành dump toàn bộ database:

    ```sh
    mysqldump --all-databases --user=root --password --master-data > masterdatabase.sql
    ```

    >Nhập password của user root khi được yêu cầu

- Sử dụng câu lệnh `scp` để copy file vừa dump sang máy slave:

    ```sh
    scp masterdatabase.sql root@<IP_slave_machine>:/root/masterdatabase.sql
    ```

- Truy cập trở lại Mariadb để unlock tables và lấy thông tin cần thiết của master
  
  - Unlock tables để có thể thao tác lại với database:

  ```sh
  UNLOCK TABLES;
  ```

  - Lấy thông tin cần thiết của master:

  ```sh
  SHOW MASTER STATUS:
  ```

  - Thông tin trả về cơ bản như sau:

  ```sh
    +----------------+----------+--------------+------------------+
    | File           | Position | Binlog_Do_DB | Binlog_Ignore_DB |
    +----------------+----------+--------------+------------------+
    | master.000001  |      326 | replica_db   |                  |
    +----------------+----------+--------------+------------------+
    1 row in set (0.001 sec)
  ```

  >Hãy lưu lại các thông tin này để cấu hình cho máy slave.

### <a name="2.2" >2.2 Cấu hình trên máy slave</a>

- Khai báo sử dụng port 3306 với firewalld:

    ```sh
    firewall-cmd --add-port=3306/tcp --zone=public --permanent
    ```

- Reload để nhận lại cấu hình:

    ```sh
    firewall-cmd --reload
    ```

- Sử dụng `vi` để truy cập và chỉnh sửa file config:




