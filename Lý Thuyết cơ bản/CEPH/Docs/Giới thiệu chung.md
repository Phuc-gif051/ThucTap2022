# Ceph là gì?

CEPH là một nền tảng phần mềm cho hệ thống lưu trữ miễn phí (free software storage platform), là một giải pháp mã nguồn mở cho phép xây dựng hạ tầng lưu trữ dữ liệu phân tán, ổn định, độ tin cậy và hiệu năng cao, dễ dàng mở rộng trong tương lai.

Với hệ thống lưu trữ được điều khiển bằng phần mềm (software defined), Ceph cung cấp giải pháp lưu trữ theo các cách phổ biến nhất: File, Block, Object trong cùng 1 nền tảng. Ceph dễ dàng triển khai với nhân Linux và hỗ trợ tốt cả các phần cứng đã cũ, tối ưu hoá chi phí nhiều nhất có thể. 

CEPH được sử dụng để thay thế việc lưu trữ dữ liệu trên các máy chủ, sao lưu dữ liệu, tạo ra một khu vực lưu trữ dữ liệu an toàn, cho phép triển khai các dịch vụ HA (high availability).

# Ceph được dùng để làm gì?

Ceph được sử dụng với các mục đích lưu trữ khác nhau dưới nhiều hình thức như :
  + Ceph Object Storage, 
  + Ceph Block Storage  
  + và Ceph File System.
> Object và Block của Ceph thường thấy trong các nền tảng điện toán đám mây

# Các thành phần cơ bản của Ceph

Về cơ bản, khi triển khai 1 ceph thì ta đều bắt đầu từ việc xây dựng cách ceph riêng lẻ (node). Sau đó kết nối chúng lại với nhau thông qua môi trường mạng, thành 1 lưu trữ sử dụng ceph (Ceph Storage Cluster). Một Ceph storage cluster cần ít nhất 1 Ceph Monitor và 2 Ceph OSD Daemons. Ngoài ra, Ceph metadata server chỉ cần thiết khi trong hệ thống có Ceph File system clients.

### [Reliable Autonomic Distributed Object Store (RADOS)]()

Yếu tố nền tảng tạo nên Ceph storage cluster. Ceph data được lưu trên object, RADOS obj chịu trách nhiệm lưu trữ, bất kể loại dữ liệu.

RADOS layer chắc chắn data sẽ luôn chính xác, bảo đảm. Về tính nhất quán, nó sẽ được nhân bản, phát hiện lỗi, khôi phục trên mọi node trong cluster.

Khi app lưu trữ tới Ceph cluster, data sẽ được lưu tại Ceph Object Storage Device (OSD) dưới dạng object. Đây là thành phần duy nhất mà Ceph cluster sử dụng để lữu trữ data và lấy lại. Thông thường, tổng số physical disk trong Ceph cluster sẽ = số lượng OSD daemon chạy lưu trữ data tới mỗi disk.

### [Block Device hay RADOS block device (RBD)]()

Thành phần cung cấp block storage, có thể mapped, formmatted, mounted như bất kỳ disk thông thường. Ceph block device hỗ trợ các tính năng provisioning và snapshots (chức năng cần thiết cho doanh nghiệp).

### [Monitors (MON)]()

Ceph monitor sẽ theo dõi trạng thái của cluster, bao gồm việc theo dõi các monitor map, OSD map, placement group (PG) map, và CRUSH map. Ceph lưu thông tin lịch sử (trong ceph gọi là “epoch”) của mỗi trạng thái thay đổi của Ceph Monitors, Ceph OSD Daemons, và PGs. 

### [Ceph OSDs (Object Storage Daemons):]()

Ceph OSD daemon (Ceph OSD) lưu trữ data, xử lý việc đồng bộ dữ liệu, recovery, rebalancing và cung cấp thông tin liên quan đến monitoring đến cho Ceph monitoring bằng cách kiểm tra các Ceph OSD daemons khác thông qua heartbeat. Một ceph storage cluster cần ít nhất 2 ceph OSD daemons để hướng tới trạng thái active + clean, lúc này hệ thống sẽ có 02 bản copy của data (default của Ceph là 3 bản).

### [MDSs (MetaData server):]()

Một Ceph Metadata Server (MDS) lưu trữ thông tin về metadata của hệ thống Ceph File System (ceph block device và object storage không sử dụng MDS).

_Thông thường Ceph lưu trữ dữ liệu của client dưới dạng các objects trong các pool lưu trữ. Ceph sử dụng thuật toán CRUSH, trong đó Ceph sẽ tính toán placement group nào sẽ lưu trữ object, và tính toán Ceph OSD Daemon nào sẽ lưu trữ placement group. CRUSH algorithm cho phép Ceph Storage cluster khả năng mở rộng, tự cân bằng (rebalance), và recovery tự động._

### [Ceph Object Gateway hay RADOS gateway (RGW):]()

Thành phần cung cấp giao diện RESTful API, tương thích với Amazone S3 (Simple Storage Service) và OpenStack Object Storage API (Swift). RGW cũng hỗ trợ OpenStack Keystone authentication services.

### [Ceph manager:]()
Bản phát hành Kraken đã mang đến sự ra mắt của trình nền Ceph Manager (ceph-mgr), chạy cùng với MON để cung cấp các dịch vụ toàn cụm thông qua kiến trúc plugin. Mặc dù việc khai thác ceph-mgr vẫn còn non trẻ, nhưng nó có nhiều tiềm năng:
  - Quản lý trạng thái ổ đĩa
  - Quản lý tốt hơn các hoạt động tái cấu trúc và tái cân bằng.
  - Tích hợp với các hệ thống kiểm kê bên ngoài như RackTables, NetBox, HP SIM và Cisco UCS Manager
  - ..v.vv.

### [Ceph File System (CephFS):]()

Thành phần cung cấp POSIX-compliant, phân phối filesystem cho mọi kiểu. CephFS dựa trên Ceph MDS để thể hiện tính phân cấp file, metadata.

# Yêu cầu phần cứng

Ceph được thiết kế để chạy trên cả các nền tảng phần cứng thông thường, với quan điểm thiết kế các hệ thống lưu trữ – mở rộng đến hàng petabyte nhưng với chi phí rẻ, hợp lý. Khi xây dựng hệ thống Ceph, cần lưu ý khuyến cáo xây dựng một hệ thống Ceph riêng, chỉ phục vụ cho vấn đề lưu trữ, để cung cấp dịch vụ lưu trữ cho các hệ thống khác sử dụng.

## CPU:
 - Ceph MDS cần nhiều CPU hơn các thành phần khác trong hệ thống, khuyến cáo sử dụng quad core hoặc CPU tốt hơn.
 - Ceph OSDs chạy RADOS service, tính toán data placement với thuật toán CRUSH, đồng bộ dữ liệu, và duy trì bản copy của cluster map. Vì vậy, OSDs cũng cần 1 lượng CPU nhất định, khuyến nghị sử dụng dual core processors.
 - Monitor hoạt động không cần nhiều CPU. Cần lưu ý trong trường hợp máy chủ chạy dịch vụ tính toán trên các OSD, ví dụ mô hình hoạt động của OpenStack – kết hợp giữa compute node và storage node, cần thiết kế CPU để bảo đảm đủ năng lực dành riêng cho Ceph daemons.
 > Khuyến cáo nên tách riêng các chức năng để bảo đảm hoạt động.

## RAM:

  - Metadata servers và monitors hoạt động liên tục để phục vụ cho dữ liệu, vì vậy cần số lượng RAM kha khá, thông thường 1Gb RAM cho mỗi instance daemon.
  - OSD không cần nhiều RAM cho các hoạt động của nó, thông thường vào khoảng 500Mb cho mỗi instance daemon. Tuy nhiên, trong quá trình recovery sẽ cần nhiều RAM, thường 1Gb cho mỗi 1Tb lưu trữ trên mỗi daemon.
  > Nhìn chung, càng nhiều RAM càng tốt, nhất là khi RAM là tài nguyên rẻ nhất hiện nay đối với máy tính, máy chủ.

## DISK:
  > Đây là yếu tố quan trọng nhất, cần cân nhắc thật kỹ giữa vấn đề chi phí và năng lực hệ thống.
  - OSDs có thể là SSD, HDD hoặc NVME sử dụng để lưu trữ data. Khuyến cáo sử dụng các đĩa cứng từ 1Tb trở lên. Cần quan tâm đến cách tính chi phí cho mỗi 1Gb lưu trữ. Ví dụ xài các đĩa cứng 1Tb ($75) thì chi phí ra sao ($0.07/1Gb) so với xài 1 đĩa cứng 3Tb ($150) thì chi phí như thế nào ($0.05/1Gb). Tuy nhiên, cần lưu ý khi dung lượng lưu trữ lớn, Ceph OSD Daemon cần thêm RAM, đặc biệt trong quá trình rebalancing, backfilling, và recovery. Khuyến cáo: 1Gb RAM cho 1 Tb không gian lưu trữ.
  - Các điểm quan trọng cần lưu ý khi triển khai đó là cần tách biệt các disk cho HĐH (OS) với các Ceph OSD Daemon, tránh việc chạy chung nhiều Ceph OSD daemon trên 1 disk, cũng như tránh chạy Ceph OSD trên MDS hay monitoring trên cùng 1 disk. Ngoài ra, OS, OSD Data, và OSD Journals nên được đặt trên các disk khác nhau, trong đó Journals sử dụng các đĩa cứng SSD để tăng tốc độ truy xuất dữ liệu cho các node lưu trữ OSD.
  > Việc thiết kế, sử dụng các đĩa cứng trong hệ thống CEPH thực tế như thế nào tùy thuộc vào nhu cầu của từng hệ thống.




Tham khảo tại: 

[lacoski/khoa-luan/blob/master/Ceph/ceph-overview](https://github.com/lacoski/khoa-luan/blob/master/Ceph/ceph-overview.md)

[notes-storage/blob/master/ceph/theory/overview](https://github.com/thaonv1/notes-storage/blob/master/ceph/theory/overview.md)

[Ceph storage là gì](https://www.xn--st-j9s.vn/2022/03/meo-ceph-storage-la-gi.html#)

[Giải pháp lưu trữ dữ liệu nguồn mở CEPH là gì?](https://taknet.com.vn/giai-phap-luu-tru-du-lieu-nguon-mo-ceph-la-gi/)
