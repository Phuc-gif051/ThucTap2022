## <a name="1" >I. Cơ bản về Ansible</a>

Ansible là công cụ hỗ trợ tự động hoá các công việc cần làm trong khi triển khai các hệ thống máy chủ, ví dụ như cài đặt: wordpress, CEPH, HAproxy,... Chủ yếu dùng cho các hệ thống máy chủ sử dụng Linux.

Các ứng dụng nổi bật của Ansible:

- Đảm bảo việc quản lý cấu hình của thiết bị, ứng dụng một cách hiệu quả, tức là quản lý đơn giản, kiểm soát được các cấu hình đúng và đủ hay chưa, chúng chạy có chính xác hay không.
- Tiết kiệm được công sức & thời gian khi phải triển khai đi triển khai lại.
- Tái sử dụng được các bước triển khai trước đó (các bước lặp đi lặp lại khi cài đặt, cấu hình máy chủ, cấu hình ứng dụng)
- Tự động hóa và áp dụng hàng loạt các việc trên hoàng loạt các server, hàng loạt các ứng dụng với thời gian ngắn nhất.

Và trước khi muốn bắt tay vào sử dụng Ansible thì ta cần phải nắm chắc được các thành phần, cách thức triển khai cấu hình cơ bản cho ứng dụng mà ta muốn triển khai. Hoặc chí ít ta nên tự viết được hoặc đọc hiểu được các script bằng bash shell.

## <a name="2" >II. Hiểu hơn về Ansible</a>

### <a name="2.1" >1. Các thuật ngữ thường gặp</a>

Dưới đây là danh sách một số thuật ngữ được sử dụng trong Ansible:

- Control Node/Management Control: server cài đặt Ansible, chịu trách nhiệm cho việc “đưa các công việc bạn cung cấp đến các server từ xa mà bạn quản lý và chạy chúng” .Nói một cách dễ hiểu hơn thì đây là server mà bạn đứng trên đó và lệnh cho các server khác thực hiện các việc bạn muốn mà không cần trực tiếp đăng nhập vào chúng.
- Inventory: Một file INI chứa các thông tin về các server từ xa mà bạn quản lý. Thường thì nó là các địa chỉ IPv4 hoặc các hostname. Có thể được gom nhóm các server lại với nhau tuỳ theo mục đích sử dụng.
- Playbook: Một file [YAML](https://en.wikipedia.org/wiki/YAML) - với đuôi file là `.yml` chứa một tập các công việc cần tự động hóa.
- Tasks: một hoặc nhiều công việc sẽ được thực hiện.
- Modules: Một Module sẽ trừu tượng hóa một tác vụ hệ thống. Hay có thể hiểu là các câu lệnh điều khiển hệ thống ta sẽ không thể sử dụng trực tiếp trong Ansible mà cần thông qua các module. Ví dụ như việc ta muốn chỉnh sửa file config nào đó thì ta cần sử dụng 1 trình soạn thảo văn bản để mở file rồi tiến hành tìm kiếm chỉnh sửa. Với module của Ansible thì ta chỉ cần cung cấp đường dẫn đến file, và dữ liệu cần thay thế là có thể chỉnh sửa được, và còn chỉnh sửa đồng thời hàng loạt cho rất nhiều máy. Ansible cũng cung cấp rất nhiều Module tích hợp để ta sử dụng nhưng nếu muốn bạn cũng có thể tự tạo Module.
- Roles: Một tập hợp các Playbook, các template và các file khác, được tổ chức theo cách được xác định trước để tạo điều kiện tái sử dụng và chia sẻ.
- Play: Một lần thực thi
- Group vars: chứa các biến toàn cục cho một lần thực thi triển khai.
- Facts/Gathering Facts: chứa các thông tin về hệ thống, như các network interface hay operating system.
- Handlers: thường chứa các playbook kích hoạt thay đổi trạng thái các service, như việc ta restart hay reload một service

Ví dụ:

<p align="center">
 <img src="Images/vidu_ansible.png" width="">
</p>

>Bạn đứng trên một Node Control và ra lệnh cho các server mà bạn quản lý.
>
>Tuy nhiên vấn đề đặt ra là số lượng thao tác cần thực hiện trên các server kìa thì nhiều, nhiều server có tác dụng,nhiệm vụ giống nhau nên cần thực hiện các tháo tác giống nhau.
>
>Vậy không lẽ bạn định gõ tay hàng trăm thậm chí hàng ngàn lệnh. Để rồi khi có một server mới, bạn lại gõ tay lại, chưa kể việc sai sót khi thao tác.
>
>Lúc này bạn sẽ cần viết một Playbook - nơi sẽ chứa chi tiết tất cả những gì bạn muốn làm với các server từ xa kia và cách thức thực hiện chúng
>
>Mỗi một thao tác trong Playbook gọi là một Task (Cài đặt, khởi động, dừng,....)
>
>Ta sử dụng Module để tạo thành Task (Ví dụ: muốn cài đặt một gói trên CentOs7 ta sử dụng Module yum của Ansible).
>
>Có việc cần làm rồi, giờ ta cần truyền thông tin chi tiết hơn về server cho Playbook chứ không thì làm sao nó biết sẽ làm việc với ai. Lúc này ta cần đến  
#### Tài liệu tham khảo từ anh Cong To

<https://news.cloud365.vn/tag/ansible/>

