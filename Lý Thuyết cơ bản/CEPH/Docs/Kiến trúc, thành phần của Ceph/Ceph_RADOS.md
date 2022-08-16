# RADOS (Reliable Autonomic Distributed Object Store)
Lớp RADOS giữ vai trò đặc biệt quan trọng trong kiến trúc Ceph, là trung tâm của Ceph storage system, cũng được gọi là Ceph Storage Cluster.

RADOS cung cấp rất nhiều tính năng quan trọng cho Ceph, bao gồm phân bố lưu trữ đối tượng, HA, bảo đảm, chịu lỗi, tự xử lý, tự giám sát. Vì vậy, RADOS layer cực kỳ quan trọng trong kiến trúc Ceph storage. Tất cả các phương thức truy cập vd: RBD, CephFS, RADOSGW, librados đều hoạt động trên RADOS layer.

<img src="https://user-images.githubusercontent.com/79830542/184786684-25e61682-ff21-4fcd-b8a2-ece099beade3.png" width="300">

Khi Ceph cluster nhận một yêu cầu ghi từ người dùng, thuật toán [CRUSH (Controlled, Scalable, Decentralized Placement of Replicated Data)](https://docs.ceph.com/en/quincy/rados/operations/crush-map/) tính toán vị trí và thiết bị mà dữ liệu sẽ được ghi vào. Các thông tin này được đưa lên lớp RADOS để xử lý. Dựa vào quy tắc của CRUSH, RADOS phân tán dữ liệu lên tất cả các node dưới dạng các object, phân chia lưu trữ dưới các [PG](https://github.com/lacoski/ceph-note/blob/master/docs/ceph/ceph-pgs.md). Cuối cùng ,các object này được lưu tại các OSD.

RADOS, khi cấu hình với số nhân bản nhiều hơn hai, sẽ chịu trách nhiệm về độ tin cậy của dữ liệu. Nó sao chép object, tạo các bản sao và lưu trữ tại các node khác nhau, do đó các bản ghi giống nhau không nằm trên cùng 1 node. RADOS đảm bảo có nhiều hơn một bản copy của object trong Ceph cluster. Tuy nhiên để phù hợp nhất với nhu cầu sử dụng và hạ tầng hiện có, ta nên tinh chỉnh lại CRUSH cho phù hợp.

RADOS cũng đảm bảo object luôn nhất quán. Trong trường hợp object không nhất quán, tiến trình khôi phục sẽ chạy. Tiến trình này chạy tự động và trong suốt với người dùng, do đó mang lại khả năng tự sửa lỗi và tự quẩn lý cho Ceph. 

RADOS có 2 phần: phần thấp không tương tác trực tiếp với giao diện người dùng, và phần cao hơn có tất cả giao diện người dùng.

RADOS lưu dữ liệu dưới trạng thái các object trong pool.

Để liệt kê danh sách các pool:

```sh
rados lspools
```

Để liệt kê các object trong pool:

```sh
rados -p {pool-name} ls
```

Để kiểm tra tài nguyên sử dụng:

```sh
rados df
```

