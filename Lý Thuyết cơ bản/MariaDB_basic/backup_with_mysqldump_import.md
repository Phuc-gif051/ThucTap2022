## Nội dung chính

_Đảm bảo tính toàn vẹn của dữ liệu với dump/import_

[mysqldump](#1)

[Một số câu lệnh cơ bản](#2)

[Tài liệu tham khảo](#0)

## <a name="1" >mysqldump</a>

- Là cách thức backup databases mặc định, được viết bởi Igor Romanenko. Chủ yếu dùng để trích xuất cơ sở dữ liệu (đôi khi để thu thập) phục vụ cho việc sao lưu hoặc di chuyển cơ sở dữ liệu sang nơi khác 1 cách nhanh chóng, thuận tiện, dễ dàng. Mặc định file được tạo ra với định dạng dữ liệu là SQL, chứa các câu lệnh SQL để tạo bảng , điền bảng, hoặc cả 2. Tuy nhiên cũng có thể tạo ra các file với các dịnh dạng khác như: CSV, text, XML, PHP,...

- Các `triggers` sẽ được trích xuất cùng với các bảng, vì nó là 1 phần tạo nên các bảng. Còn các [procedures](https://mariadb.com/kb/en/stored-procedures/), [views](https://mariadb.com/kb/en/views/), [events](https://mariadb.com/kb/en/events/) thì không, và cần các thông số bổ sung để khởi tạo lại

- Vì đây là back-up bằng cách tạo ra các tệp back-up ngay trên máy local nên, ít nhiều sẽ phải sử dụng CPU nhưng sẽ chỉ sử dụng 1 luồng duy nhất, cho nên sẽ không ảnh hưởng quá nhiều tới hiệu năng của máy chủ.

- Tuy nhiên với ổ cứng thì ngược lại, nếu là 1 databases lớn thì ảnh hưởng rất nhiều đến hiệu năng của ổ cứng vì hệ thống sẽ vừa phải đọc lượng lớn dữ liệu trong ổ cứng, vừa phải tiến hành ghi 1 lượng lớn thông tin để tạo ra các bản sao dữ liệu. Với các hệ thống lớn cần cân nhắc kỹ khi thực hiện dump.

- Bốn cách đơn giản để sử dụng mysqldump:

        shell> mysqldump [options] db_name [tbl_name ...]
        shell> mysqldump [options] --databases db_name ...
        shell> mysqldump [options] --all-databases
        shell> mysqldump [options] --system=[option_list]

- Khi không có database hay option cụ thể nào để chỉ định hãy sử dụng `--all-databases`, toàn bộ cơ sở dữ liệu sẽ được sao lưu.

Xem chi tiết các `options`: <https://mariadb.com/kb/en/mariadb-dumpmysqldump/#options>

## <a name="2" >Một số câu lệnh cơ bản</a>

- Backup a Single MySQL Database

    ```sh
    mysqldump -u root -p database_name > database_name.sql
    ```

  - Trong đó
    - u : tài khoản sở hữu database
    - p : sử dụng password để đăng nhập vào tài khoản, sẽ được yêu cầu sau khi chạy câu lệnh

- Backup Multiple MySQL Databases

    ```sh
    mysqldump -u root -p --databases database_name_a database_name_b > databases_a_b.sql
    ```

- Backup All MySQL Databases

    ```sh
    mysqldump -u root -p --all-databases > all_databases.sql
    ```

- Restoring a MySQL dump

    ```sh
    mysql -u <user_name> -p <password> database_name < file.sql
    ```

    >Đổ dữ liệu vào 1 database đã có sẵn

    ```sh
    mysql -u root -p -e "create database database_name";
    mysql -u root -p database_name < database_name.sql
    ```

    >Tạo mới, và đổ dữ liệu vào database vừa tạo.

## <a name="0" >Tài liệu tham khảo</a>

<https://mariadb.com/kb/en/mariadb-dumpmysqldump/>

<https://linuxize.com/post/how-to-back-up-and-restore-mysql-databases-with-mysqldump/>

date accessed: 14/11/2022
