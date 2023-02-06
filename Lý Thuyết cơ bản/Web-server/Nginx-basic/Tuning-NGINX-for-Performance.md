# Nội dung chính

_Cấu hình Nginx cho hiệu suất tốt nhất có thể. Các cấu hình và thông số trong bài chủ yếu dành cho môi trường thử nghiệm_

## <a name="1" >I. Lý thuyết</a>

- Đầu tiên, ta cần mở rộng Backlog của hệ thống (ở đây là hệ thống Linux - CentOS 7) và số connect tối đa đến hệ thống. Hiểu cơ bản thì Backlog là danh sách lưu trữ các kết nối đến hệ thống theo kiểu hàng đợi. Giới hạn phổ biến của Backlog là 65535.

>Xem chi tiết tại đây: [Backlog](https://veithen.io/2014/01/01/how-tcp-backlog-works-in-linux.html#:~:text=When%20an%20application%20puts%20a%20socket%20into%20LISTEN,the%20limit%20for%20the%20queue%20of%20incoming%20connections.)

Xem giá trị mặc định ban đầu:

  ```sh
  cat /proc/sys/net/core/somaxconn
  cat /proc/sys/net/core/netdev_max_backlog
  ```

Mở rộng với câu lệnh sau:

  ```sh
  sudo echo "net.core.netdev_max_backlog = 65535" | tee -a /etc/sysctl.conf
  sudo echo "net.core.somaxconn = 65535" | tee -a /etc/sysctl.conf
  sudo sysctl -p
  ```

Việc thay đổi cấu hình này ảnh hưởng trực tiếp đến php-fpm nên cần khởi chạy lại để nhận cấu hình mới:

  ```sh
  service php-fpm restart
  ```

>Tham khảo mở rộng backlog tại đây: 

<https://veithen.io/2014/01/01/how-tcp-backlog-works-in-linux.html#:~:text=When%20an%20application%20puts%20a%20socket%20into%20LISTEN,the%20limit%20for%20the%20queue%20of%20incoming%20connections.>

<https://stackoverflow.com/questions/62641621/what-is-the-difference-between-tcp-max-syn-backlog-and-somaxconn>

<https://serverfault.com/questions/867866/11-resource-temporarily-unavailable-while-connecting-to-upstream-bad-gateway>

- Tiếp theo là cần mở rộng số file tối đa mà 1 chương trình trong hệ thống có thể mở (chủ yếu phục vụ cho môi trường kiểm thử để kiểm tra hiệu năng của hệ thống)

Thông thường, giá trị tối đa của file-max là: [RAM (tính theo MB)/4]*256. Mặc định giá trị của nó 4096.

Tham khảo thêm về giá trị của file-max: <https://unix.stackexchange.com/questions/551481/how-to-find-max-limit-of-proc-sys-fs-file-max>

Để thay đổi giá trị cho phù hợp với nhu cầu sử dụng của Nginx, ta có 2 cách:
  
  - Cách 1: without systemd

     Truy cập vào file config:

    ```sh
    vi /etc/sysctl.conf
    ```
  
    Nhập vào giá trị:

    ```sh
    fs.file-max = 70000
    ```

    Lưu lại và thoát, tiếp tục chỉnh sửa trong file tiếp theo:

    ```sh
    vi /etc/security/limits.conf
    ```

    Nhập vào nội dung sau:

    ```sh
    nginx       soft    nofile   10000
    nginx       hard    nofile  30000
    ```

    Lưu lại và thoát, khởi động lại để nhận config mới:

    ```sh
    sysctl -p
    ```

  - Cách 2: with systemd
    Thực hiện câu lệnh:

    ```sh
    systemctl edit nginx.service
    ```
    
    Nhập vào giá trị:

    ```sh
    [Service]
    LimitNOFILE=65535
    ```

    Khởi động lại:

    ```sh
    systemctl daemon-reload
    ```

- Cuối cùng chỉnh sửa file config của nginx theo hướng dẫn cực kỳ chi tiết sau:

<https://github.com/denji/nginx-tuning>

### Tài liệu tham khảo

- Lý thuyết: <https://www.nginx.com/blog/tuning-nginx/>
- Thay đổi config: <https://github.com/denji/nginx-tuning>
- Bài thuyết trình của kỹ sư Nginx: <https://www.youtube.com/watch?v=YEdhuC2muOE>
- Để kiểm tra hiệu suất có thể dùng:
  
  - Locust: <https://docs.locust.io/en/stable/installation.html>
  - Apache-Jmeter: <https://jmeter.apache.org/>

Date accessed: 03/02/2023

