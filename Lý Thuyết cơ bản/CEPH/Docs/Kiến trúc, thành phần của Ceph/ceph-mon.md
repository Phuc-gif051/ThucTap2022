# Ceph Monitor (MON)

Ceph monitor chịu trách nhiệm giám sát toàn cluster. Tiến trình này chạy trên toàn cluster, giám sát dựa trên thông tin cluster, trạng thái các node, các cấu hình Cluster. Ceph monitor thực hiện nhiệm vụ bằng cách duy trì master copy trên cluster. Cluster map bao gồm OSD, PG, CRUSH, MDS maps.
- **Monitor map**: map này lưu giữ thông tin về các node monitor, gồm CEPH Cluster ID, monitor hostname, địa chỉ IP và số port. Nó cũng giữ epoch (phiên bản map tại một thời điểm) hiện tại để tạo map và thông tin về lần thay đổi map cuối cùng. Có thể kiểm tra bằng câu lệnh:
```
ceph mon dump
```

- **OSD map**: map này lưu giữ các trường như cluster ID, epoch cho việc tạo map OSD và lần thay đổi cuối., và thông tin liên quan đến pool như tên, ID, loại, mức nhân bản và PG. Nó cũng lưu các thông tin OSD như tình trạng, trọng số, thông tin host OSD. Có thể kiểm tra OSD map bằng câu lệnh:
```
ceph osd dump
```

- **PG map**: map này lưu giữ các phiên bản của PG (thành phần quản lý các object trong ceph), timestamp, bản OSD map cuối cùng, tỉ lệ đầy và gần đầy dung lượng. Nó cũng lưu các ID của PG, object count, tình trạng hoạt động và srub (hoạt động kiểm tra tính nhất quán của dữ liệu lưu trữ). Kiểm tra PG map bằng lệnh:
```
ceph pg dump
```

- **CRUSH map**: map này lưu các thông tin của các thiết bị lưu trữ trong Cluster, các rule cho tưng vùng lưu trữ. Kiểm tra CRUSH map bằng lệnh:
```
ceph osd crush dump
```

- **MDS map**: lưu thông tin về thời gian tạo và chỉnh sửa, dữ liệu và metadata pool ID, cluster MDS count, tình trạng hoạt động của MDS, epoch của MDS map hiện tại. Kiểm tra MDS map bằng lệnh:
```
ceph mds dump
```

Ceph monitor không lưu data và phục vụ user. Nó sẽ tập trung vào update cluster map tới client và cluster node. Client và cluster node kiểm tra theo chu kỳ.

Tiến trình giám sát rất nhẹ, nó sẽ ko ảnh hướng tới tài nguyên có sẵn của server. Monitor node cần có đủ dung lượng đễ lưu trữ cluster log bao gồm OSD, MDS và monitor logs.

Ceph cluster bao gồm nhiều hơn 1 monitor node. Kiến trúc Ceph được thiết kế quorum and provides consensus khi đưa ra quyết định phân tán cluster bằng thuật toán Paxos. Monitor count trong cluster là 1 số lẻ, tối thiểu 1 – 3. Trong tất cả các cluster monitor, sẽ có 1 hoạt động như leader. Phiên bản thương mại cần ít nhất 3 monitor node cho HA

>Tùy thuộc vào điều kiện kinh tế, tiến trình monitor có thể chạy trên cùng OSD node. Tuy nhiên sẽ cần nhiều CPU, RAM, disk cho việc lưu trữ log.
