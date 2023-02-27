## Nội dung chính

[KVM là gì](#kvm-là-gì)

[KVM hoạt động ra sao?](#kvm-hoạt-động-ra-sao)

[Tính năng của KVM](#tính-năng-của-kvm)

[Ưu và nhược điểm của KVM](#ưu-và-nhược-điểm-của-kvm)

[Tài liệu tham khảo](#tài-liệu-tham-khảo)

___

## KVM là gì?

KVM là từ viết tắt của Kernel Virtualization Machine hoặc Kernel-based Virtual Machine, được giới thiệu là công nghệ ảo hóa phần cứng có mã nguồn mở. Điều này có nghĩa là hệ điều hành chính OS có nhiệm vụ mô phỏng phần cứng cho các OS khác để chạy trên đó.

Chính vì vậy, ảo hóa KVM có cách hoạt động giống như người quản lý, giúp chia sẻ các nguồn tài nguyên ổ đĩa, network, CPU một cách tối ưu nhất. Ngoài ra, công nghệ ảo hóa KVM còn được tích hợp trong Linux như sau:

- Với công nghệ ảo hóa KVM, bạn có thể biến Linux thành một trình ảo hoá, cho phép máy chủ chạy nhiều môi trường ảo hoá biệt lập gọi là máy khách hay máy ảo (virtual machines - VMs)
- KVM là một phần của mã Linux (từ phiên bản Linux 2.6.20 trở lên) khi đó, KVM sẽ được thừa hưởng mọi tính năng, khả năng sửa lỗi và tiến bộ cập nhật mới của Linux mà không cần kỹ thuật bổ sung.

## KVM hoạt động ra sao?

Về cơ bản, mỗi kiểu ảo hoá đều cần các tiến trình cấp hệ điều hành để quản lý như: quản lý RAM, quản lý đọc ghi ( input/output (I/O)), quản lý bảo mật, network,...để có thể chạy máy ảo (VMs). Và KVM chuyển đổi Linux thành một trình ảo hoá loại 1 (bare-metal). KVM có sẵn tất cả các thành phần yêu cầu kể trên vì nó là một phần của Linux. Mỗi VMs sẽ được triển khai như một tiến trình Linux thông thường, được quản lý và lên kế hoạch bởi Linux scheduler, với các phần cứng ảo cần thiết như card mạng, disk, CPUs, bộ điều khiển đồ hoạ.

## Tính năng của KVM

- `Bảo mật`: KVM bắt buộc sử dụng SELinux ([security-enhanced Linux (SELinux)](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/deployment_guide/rhlcommon-appendix-0005)) kết hợp với ảo hoá an toàn (secure virtualization (sVirt)) cho tăng cường bảo mật và cách ly VMs. SELinux sẽ thiết lập các ranh giới bảo mật xung quanh các VMs. sVirt tăng cường khả năng của SELinux, cho phép áp dụng bảo mật Kiểm soát truy cập bắt buộc (Mandatory Access Control - MAC) cho các máy ảo khách và ngăn các lỗi ghi nhãn thủ công (manual labeling errors).

- `Lưu trữ`: KVM cho phép sử dụng bất kỳ dạng lưu trữ nào là Linux được hỗ trợ, từ các các ổ cứng vật lý, đến các dạng chia sẻ lưu trữ qua mạng (network-attached storage (NAS)). Đôi khi đọc ghi đa luồng (Multipath I/O) cũng được sử dụng để cải thiện hiệu suất và cung cấp khả năng dự phòng. KVM cũng hỗ trợ chia sẻ file system, vì thế có thể chia sẻ VM images cho nhiều máy. Disk images hỗ trợ và được khuyến khích nên dùng thin provisioning để cung cấp dung lượng theo yêu cầu sử dụng.

- `Hỗ trợ phần cứng`: Kết hợp với các nhà cung cấp phần cứng đã được Linux chứng nhận, các tính năng mới của phần cứng thường xuyên được cập nhật. Và KVM nghiễm nhiên cũng có các tính năng mới này để phù hợp với các phần cứng mới.

- `Quản lý bộ nhớ`: KVM kế thừa các tính năng quản lý bộ nhớ của Linux, bao gồm truy cập bộ nhớ không thống nhất (non-uniform memory access) và kernel same-page merging (tính năng cho phép các VMs chia sẻ các trang bộ nhớ giống hệt nhau, thường là các thư viện phổ biến, các tệp truy cập nhiều,...một vài tính năng hữu ích khác). Bộ nhớ trên VMs có thể thực hiện swapped, hỗ trợ bởi bộ nhớ lớn cho hiệu suất cao hơn, và sẻ hoặc hỗ trợ bởi tệp đĩa.

- `Di chuyển công nghệ ảo hóa KVM trực tiếp - Live migration`: KVM sẽ cho phép bạn di chuyển ảo hóa trực tiếp – nghĩa là di chuyển một chương trình ảo hóa đang chạy giữa các máy chủ vật lý mà không gây ra bất kỳ sự gián đoạn nào. Lúc này, KVM vẫn được bật, mọi kết nối mạng và ứng dụng vẫn hoạt động bình thường. Đồng thời trong quá trình di chuyển KVM cũng lưu lại trạng thái hiện tại của VMs để có thể lưu trữ và tiếp tục lại nếu gặp sự cố.

- `Hiệu suất, khả năng mở rộng - Performance and scalability`: KVM kế thừa hiệu suất của Linux, có khả năng mở rộng quy mô để phù hợp với nhu cầu tải nếu số lượng máy khách và yêu cầu tăng lên. KVM cho phép ảo hóa khối lượng công việc ứng dụng đòi hỏi khắt khe nhất và là cơ sở cho nhiều thiết lập ảo hóa doanh nghiệp, chẳng hạn như datacenters and private clouds (via [OpenStack®](https://www.redhat.com/en/topics/openstack)).

- `Độ trễ thấp hơn và mức độ ưu tiên cao hơn - Lower latency and higher prioritization`: Nhân Linux có các tiện ích mở rộng thời gian thực cho phép các ứng dụng dựa trên VM chạy ở độ trễ thấp hơn với mức độ ưu tiên tốt hơn. Nhân cũng chia các quy trình đòi hỏi thời gian tính toán lâu thành các thành phần nhỏ hơn, sau đó được lên lịch và xử lý tương ứng.

- `Quản lý KVM`: Có thể quản lý các VM từ 01 máy vật lý trong cụm máy vật lý mà không cần các công cụ quản lý. Các doanh nghiệp lớn sử dụng phần mềm quản lý ảo hóa có giao diện với môi trường ảo và phần cứng vật lý cơ bản để đơn giản hóa việc quản trị tài nguyên, tăng cường phân tích dữ liệu và hợp lý hóa các hoạt động.

## Ưu và nhược điểm của KVM

### Ưu điểm

- Khả năng linh hoạt: Mặc dù máy chủ gốc được cài đặt Linux, nhưng KVM hỗ trợ tạo máy chủ ảo có thể chạy cả Linux, Windows. Khi được sử dụng kết hợp với QEMU, KVM có thể chạy Mac OS X. Ngoài ra, KVM cũng hỗ trợ cả x86 và x86-64 system.
- Có tính độc quyền cao: Cấu hình từng gói VPS KVM sẽ chỉ được một người sở hữu và toàn quyền sử dụng tài nguyên đó (bao gồm CPU, RAM, DISK SPACE…) mà không hề bị chia sẻ hay ảnh hưởng bởi các VPS khác hoạt động trên cùng hệ thống.
- Độ bảo mật chắc chắn: Nhờ tích hợp các đặc điểm bảo mật của Linux như SELinux với các cơ chế bảo mật nhiều lớp, KVM bảo vệ các máy ảo tối đa và cách ly hoàn toàn, tránh bị xâm hại.
- Giúp tiết kiệm chi phí, độ mở rộng cao: do được phát triển trên nền tảng mã nguồn mở hoàn toàn miễn phí và được hỗ trợ từ cộng đồng và nhà sản xuất thiết bị, KVM ngày càng lớn mạnh và trở thành một lựa chọn hàng đầu cho doanh nghiệp có chi phí thấp nhưng hiệu quả sử dụng đem lại cao.

### Nhược điểm

- Có yêu cầu cao về server/máy chủ: Do là công nghệ ảo hóa hoàn toàn phần cứng, KVM yêu cầu cấu hình server vật lý khá cao. Thậm chí còn yêu cầu phải sử dụng các server của các thương hiệu lớn thì mới đảm bảo hoạt động tốt được
- Công nghệ ảo hóa KVM chỉ có sẵn trong các hệ thống Linux
- Các máy chủ cần thiết lập phần cứng mạnh mẽ
- Cần tốn khá nhiều thời gian để nghiên cứu và học tập để có thể đưa vào sử dụng
- Do tập trung hóa phần cứng nên rủi ro tăng cao trong trường hợp phần cứng hệ thống bị lỗi.

## Tài liệu tham khảo

<https://www.redhat.com/en/topics/virtualization/what-is-KVM>

<https://bizflycloud.vn/tin-tuc/kvm-la-gi-20210924181610644.htm>


Date accessed: 27/02/2023