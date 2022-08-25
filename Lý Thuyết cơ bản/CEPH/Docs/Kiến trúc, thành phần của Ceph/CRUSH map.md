## <a name="I" >I. CRUSH là gì❔</a>

CRUSH trong lĩnh vực công nghệ là viết tắt của: Controlled Replication Under Scalable Hashing - sử dụng hàm băm để nhân rộng có kiểm soát. Nó là một thuật toán dựa trên hàm băm (hash) để tính toán việc lưu trữ dữ liệu dựa trên các phương diện: 
 - Cách thức lưu trữ 
 - Nơi lưu trữ 
 - Khi nào lưu trữ hay nhân bản
 - Cách thức bảo vệ dữ liệu

Chủ yếu dành cho các hệ thống lưu trữ phân tán, ví dụ như Ceph. Trong Ceph Thuật toán CRUSH là cốt lõi trong cơ chế lưu trữ của Ceph.

CRUSH cho phép máy khách Ceph giao tiếp với OSD trực tiếp thay vì thông qua máy chủ hoặc thông qua một mô giới trung gian khác (broker). Với một phương pháp lưu trữ và truy xuất dữ liệu được xác định theo thuật toán, Ceph tránh được: một điểm lỗi duy nhất (single point of failure), tắc nghẽn hiệu suất (performance bottleneck) và giới hạn vật lý đối với khả năng mở rộng của hệ thống.

CRUSH hoàn toàn có thể chạy tự động khi ta triển khai cụm Ceph hoặc cũng có thể được cấu hình cho phù hợp với hệ thống mà ta sở hữu. Việc cấu hình này được định nghĩa là `CRUSH map`.

## <a name="II" >II. CRUSH map</a>

CRUSH sử dụng `map` cho cụm Ceph (CRUSH map) để: Có thể tạo, lưu trữ ID ngẫu nhiên cho dữ liệu rồi ánh xạ chúng đến các OSDs; phân phối chúng đến toàn cụm dựa trên các thông số nhân bản đã được cấu hình từ trước;

>map ở đây không phải là bản đồ mà là một cách thức lưu trữ: các thông tin thành phần, cách cấu hình các thành phần,...cho các daemon của Ceph. Hay hiểu đơn giản là nhờ các map này ta có thể xem thông tin của các daemon, có thể cấu hình hoạt động của chúng, thêm sửa xoá các thành phần,...Chúng ta có các map tiêu biểu như: CRUSH map, Monitor map, OSD map, PG map, MDS map...

CRUSH lưu trữ toàn bộ danh sách các OSD và bucket


