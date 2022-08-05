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

# Các thành phần cơ bản khi triển khai Ceph

Về cơ bản, khi triển khai 1 ceph thì ta đều bắt đầu từ việc xây dựng cách ceph riêng lẻ (node). Sau đó kết nối chúng lại với nhau thông qua môi trường mạng, thành 1 lưu trữ sử dụng ceph (Ceph Storage Cluster). Một Ceph storage cluster cần ít nhất 1 Ceph Monitor và 2 Ceph OSD Daemons. Ngoài ra, Ceph metadata server chỉ cần thiết khi trong hệ thống có Ceph File system clients.

## Monitors: 

Ceph monitor sẽ theo dõi trạng thái của cluster, bao gồm việc theo dõi các monitor map, OSD map, placement group (PG) map, và CRUSH map. Ceph lưu thông tin lịch sử (trong ceph gọi là “epoch”) của mỗi trạng thái thay đổi của Ceph Monitors, Ceph OSD Daemons, và PGs.

## Ceph OSDs:

Ceph OSD daemon (Ceph OSD) lưu trữ data, xử lý việc đồng bộ dữ liệu, recovery, rebalancing và cung cấp thông tin liên quan đến monitoring đến cho Ceph monitoring bằng cách kiểm tra các Ceph OSD daemons khác thông qua heartbeat. Một ceph storage cluster cần ít nhất 2 ceph OSD daemons để hướng tới trạng thái active + clean, lúc này hệ thống sẽ có 02 bản copy của data (default của Ceph là 3 bản).

## MDSs:

Một Ceph Metadata Server (MDS) lưu trữ thông tin về metadata của hệ thống Ceph File System (ceph block device và object storage không sử dụng MDS).

_Thông thường Ceph lưu trữ dữ liệu của client dưới dạng các objects trong các pool lưu trữ. Ceph sử dụng thuật toán CRUSH, trong đó Ceph sẽ tính toán placement group nào sẽ lưu trữ object, và tính toán Ceph OSD Daemon nào sẽ lưu trữ placement group. CRUSH algorithm cho phép Ceph Storage cluster khả năng mở rộng, tự cân bằng (rebalance), và recovery tự động._

# Yêu cầu phần cứng

Ceph được thiết kế để chạy trên các nền tảng phần cứng thông thường, với quan điểm thiết kế các hệ thống lưu trữ – mở rộng đến hàng petabyte nhưng với chi phí rẻ, hợp lý. Khi xây dựng hệ thống Ceph, cần lưu ý khuyến cáo xây dựng một hệ thống Ceph riêng, chỉ phục vụ cho vấn đề lưu trữ, để cung cấp dịch vụ lưu trữ cho các hệ thống khác sử dụng.


Tham khảo tại: 

[Ceph storage là gì](https://www.xn--st-j9s.vn/2022/03/meo-ceph-storage-la-gi.html#)

[Giải pháp lưu trữ dữ liệu nguồn mở CEPH là gì?](https://taknet.com.vn/giai-phap-luu-tru-du-lieu-nguon-mo-ceph-la-gi/)
