## Nội dung chính

_Giới thiệu về lưu trữ phân tán trong MariaDB nhằm bảo đảm về tính an toàn cho database_


___


## <a name="1" >1. Cái nhìn tổng quan về lưu trữ phân tán</a>

Trong thời đại mà dữ liệu là tài nguyên như hiện nay thì tính toàn vẹn của dữ liệu được coi trọng hơn bao giờ hết, từ các cá nhân, cho đến các công ty, tổ chức bất kể quy mô. Đều rất quan tâm đến việc bảo đảm sự an toàn vẹn của dữ liệu.

Không nằm ngoài sự quan tâm đó thì các công cụ quản lý và lưu trữ database cũng có sự chuẩn bị, và đã sinh ra 1 khái niệm gọi là `replication` - sự nhân bản.

Đây là một tính năng cho phép ta tạo ra 1 cơ sở dữ liệu giống hệt với cơ sở dữ liệu ban đầu, được lưu trữ tại 1 một nơi khác nhằm đảm bảo tính toàn vẹn cho dữ liệu khi xảy ra sự cố.

Nơi chứa dữ liệu gốc được gọi là `Master`, nơi chứa dữ liệu nhân bản được gọi là `Slave`. Quá trình nhân bản dữ liệu từ Master về Slave được gọi là `Replication`.

Ta có thể sao chép toàn bộ cơ sở dữ liệu, hoặc 1 vài cơ sở dữ liệu riêng, hoặc 1 vài bảng trong cơ sở dữ liệu,... Sao chép có tính chọn lọc cao.

<a name="1.1" >Ưu điểm của việc dùng replication</a>

- Khả năng mở rộng - Scalability: Bằng cách có nhiều slave kết nối với 1 hoặc 2 master thì việc đọc có thể trải rộng ra nhiều slave, giảm tải cho master. Việc này cực kỳ phù hợp với kịch bản đọc nhiều ghi ít, đáp ứng được nhu cầu đọc cao đến từ phía khách hàng. Và khi dữ liệu đã đủ lớn thì các node slave ban đầu có khả năng trở thành 1 master mới, mở rộng hệ thống một cách dễ dàng.

- Phân tích dữ liệu - Data analysis: khi cần 1 một lượng dữ liệu nhất định không thay đổi để có thể phân tích thì ra có thể dừng quá trình Replication ở slave để lấy dữ liệu ra và phân tích. Việc ghi ở master hoàn toàn không bị ảnh hưởng và khi tiếp tục Replication thì dữ liệu vẫn được sao lưu 1 cách toàn vẹn, không có bất kỳ ảnh hưởng nào.

- Khả năng sao lưu - Backup: tối ưu nhất cho việc backup là khi dữ liệu không có thay đổi gì quá nhiều. Tuy nhiên với 1 cơ sở dữ liệu thì việc thay đổi liên tục là không thể tránh khỏi, ta không thể dừng việc đọc khi để tiến hành backup. Nhưng trong mô hình của replication thì ta hoàn toàn có thể dừng việc repli dữ liệu ở máy slave để backup, trong khi dữ liệu mới vẫn được ghi vào máy master, tránh tối da việc thất thoát dữ liệu.

- Phân phối dữ liệu – Distribution of data: chỉ cần 1 kết nối đến master lần đầu tiên. Sau đó muốn phân phối dữ liệu thì chỉ cần lấy từ máy slave là có thể phân phối không cần kết nối mới đến máy master.

<a name="1.2" >Nhược điểm của việc dùng replication</a>

- Nhược điểm lớn nhất là đầu tư kinh phí ban đầu khi cần nhiều hơn 1 máy để có thể replicate. Và cơ sở hạ tầng tốt để có thể hoạt động ổn định.

- Phải có nhân sự biết và hiểu rõ về hệ thống để có thể vận hành cũng như khắc phục sự cố.

- Vẫn có khả năng bị phá hoại khi bị phát hiện lỗ hổng bảo mật dù ở phía master hay slave.

## <a name="2" >2. Hoạt động của Master - Slave</a>



## <a name="0" >Tài liệu tham khảo</a>

<https://mariadb.com/kb/en/replication-cluster-multi-master/>

<https://news.cloud365.vn/gioi-thieu-ve-mariadb-replication-master-slave/>

