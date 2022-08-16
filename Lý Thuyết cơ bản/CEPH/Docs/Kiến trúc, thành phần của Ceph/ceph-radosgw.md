# Ceph Object Gateway (Ceph RADOSGW)
Ceph Obj Gateway hay RADOS gateway, là proxy chuyển đổi HTTP requests thành RADOS requests và ngược lại, cung cấp RESTful object storage, tương thích S3, Swift. Ceph Object Storage sử dụng Ceph Object Gateway daemon (radosgw) để tương tác librgw và Ceph Cluster, librados. Nó thực thi FastCGI module sử dụng libfcgi và có thể sử dụng FastCGI-capable web server.

Ceph Object Store hỗ trợ 3 giao diện:
  - S3 compatible: Cung cấp Amazon S3 RESTful API.
  - Swift compatible: Cung cấp OpenStack Swift API. Ceph Object Gateway có thể thay thế Swift.
  - Admin API: Hỗ trợ quản trị Ceph Cluster thông qua HTTP RESTful API.

<p align="center">
 <img src="https://user-images.githubusercontent.com/79830542/184798829-6d37ec9f-f9c8-482e-a039-992ab80af150.png" width="">
</p>

Ceph Object Gateway có phương thức quản lý người dùng riêng. Cả S3 và Swift API chia sẻ cùng một namespace chung trong Ceph cluster, do đó có thể ghi dữ liệu từ một API và lấy từ một API khác. Để xử lý nhanh, nó có thể dừng RAM làm cache metadata. Có thể dùng nhiều Gateway và sử dụng Load balancer để cân bằng tải vào Object Storage. Hiệu năng được cải thiện thông qua việc cắt nhỏ các REST object thành các RADOS object. Bên cạnh S3 và Swift API. Ứng dụng có thể bypass qua RADOS gateway và truy xuất trực tiếp tới librados, thường được sử dụng trong các ưgs dụng doanh nghiệp đòi hỏi hiệu năng cao. Ceph cho phép truy xuất trực tiếp tới cluster, điều khác biệt so với các hệ thống lưu trữ khác vốn giới hạn về các interface giao tiếp.
