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

>map ở đây không chỉ là bản đồ mà là một cách thức lưu trữ: các thông tin thành phần, cách cấu hình các thành phần,...cho các daemon của Ceph. Hay hiểu đơn giản là nhờ các map này ta có thể xem thông tin của các daemon, có thể cấu hình hoạt động của chúng, khi thêm sửa xoá các thành phần thì các map này cũng thay đổi,...Chúng ta có các map tiêu biểu như: CRUSH map, Monitor map, OSD map, PG map, MDS map...Các map này tồn tại trên toàn cụm Ceph.

CRUSH map lưu trữ toàn bộ danh sách các OSD, các bucket để có một danh sách tổng hợp các thiết bị lưu trữ, cùng với đó là các quy tắc chi phối cách mà CRUSH có thể lưu trữ, sao chép dữ liệu trong các nhóm của cụm Ceph. Từ đó CRUSH có khả năng đảm bảo các dữ liệu đã được sao chép sẽ được lưu trữ trên các thiết bị riêng biệt với: vị trí vật lý riêng biệt, nguồn điện riêng biệt, mạng riêng biệt,...giữa các thiết bị trong cùng một cụm. Nghĩa là từ các thông tin có trong map, thì CRUSH đảm bảo sẽ không có dữ liệu gốc và dữ liệu đã sao chép nằm trên cùng một máy hay tất cả các bản sao dữ liệu nằm trên cùng một máy. Vì thế đảm bảo được tính an toàn của dữ liệu, tính sẵn sàng cho hệ thống khi có một hoặc nhiều hơn một máy trong cụm bị hỏng (down).

Khi triển khai OSD hoặc thêm mới, chúng sẽ tự động được thêm vào CRUSH map, ngay bên dưới tên bucket của node mà sở hữu OSD mới đó. Điều này kết hợp với việc khai báo 


