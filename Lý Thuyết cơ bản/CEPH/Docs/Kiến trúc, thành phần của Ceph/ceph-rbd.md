# Ceph block device = RADOS block device (RBD)

Một trong những thành phần quan trọng sử dụng cho định dang dữ liệu trong môi trường doanh nghiệp. Cung cấp giải pháp block storage tới physical hypervisors cung cấp cho virtual machines. Ceph RBD driver được tích hợp với Linux mainline kernel và hỗ trợ QEMU/KVM, cho phép Ceph block device seamlessly.

Về cơ bản đây là 1 thin--provisioned, có khả nẳng thay đổi kích thước, lưu trữ kiểu striped trên nhiều Object Storage Devices (OSD) trong Ceph storage cluster. Ceph block devices còn được biết đến với cái tên Reliable Autonomic Distributed Object Store (RADOS) Block Devices (RBDs). Ceph block devices tận dụng được các khả năng của RADOS như:
   - Snapshots
   - Tính nhất quán của dữ liệu
   - Tự động nhân bản dữ liệu
   - ...

Ceph block devices tương tác với OSDs bằng cách sử dụng thư viện `librbd`

Với hiệu năng cao và khả năng mở rộng vô hạn thì nó rất thích hợp cho Kernel Virtual Machines (KVMs) - nhân máy ảo, nổi bật nhất là sử dụng trong các hệ thống Quick Emulator (QEMU) hay hệ thống điện toán đám mây. Ví dụ như OpenStack dựa trên `libvirt` và `QEMU` để có thể sử dụng được Ceph block devices. Ta hoàn toàn có thể chạy cùng lúc Ceph Object Gateway and Ceph block devices trên cùng một cụm lưu trữ.

Như vậy, Ceph RBD có đầu đủ sức mạnh của SAN storage, cung cấp giải pháp mức doanh nghiệp với tính năng thin-provisioning, copy-on-write snapshots and clones, revertible read-only snapshots, hỗ trợ cloud platforms như OpenStack và CloudStack.

_Tham khảo tại [Block Device Guide](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/4/html-single/block_device_guide/index#:~:text=Ceph%20block%20devices%20are%20thin-provisioned%2C%20resizable%20and%20store,Ceph%20block%20devices%20leverage%20RADOS%20capabilities%20such%20as%3A)_

