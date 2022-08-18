# <a name="I" >I. Mô hình triển khai</a>
Cài đặt Ceph trên 1 máy duy nhất, cần chuẩn bị máy chạy CentOS 7 với cấu hình tối thiểu:
  - 2 CPU, 2 GB RAM
  - 03 ổ cứng: 
       - 1 ổ để cài OS, Ceph MON,...
       - 2 ổ còn lại để cài Ceph OSDs

  - Các dải mạng của Ceph:
    - 1 dải để kết nối tới internet tải các gói cần thiết (public)
    - 1 dải để các khách hàng, người dùng truy cập vào các dịch vụ mà Ceph cung cấp (public-private)
    - 1 dải để các thành phần trong cụm Ceph nói chuyện với nhau, vận chuyển dữ liệu (private). Chỉ các thành phần trong cụm mới kết nối được tới dải này.

<img src="https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/CEPH/Docs/Images/ceph.drawio.png" width="500">
