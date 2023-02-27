## <a name="1" >1. Adding new mon using ceph-deploy</a>

- Từ node admin, khai bảo node mới với ip và tên node trong file `/etc/hosts`, tiến hành cài đặt ceph cho node mới

 ```sh
ceph-deploy install --release <version> <ceph-node>
 ```

 vd: ceph-deploy install --release nautilus client
 >kết quả cuối khi cài đặt xong tương tự như hình. Để kiểm tra lại sử dụng câu lệnh `ceph -v` trên node mới, nếu trùng phiên bản với node admin tức là cài đặt thành công
 ![image](https://user-images.githubusercontent.com/79830542/190107471-7363bd17-33ef-4ea6-b0ee-bbec30e74bfb.png)


- Chờ cho đến khi cài đặt thành công, tiến hành tạo mon mới trên node mới

```sh
ceph-deploy mon create <ceph-node>
```

vd: ceph-deploy mon create client

Kết quả cuối cùng tương tự như hình dưới
![image](https://user-images.githubusercontent.com/79830542/190119539-4020e56a-6b3b-4976-b538-247046f2f9ec.png)

- Khởi tạo thành công, thì thực hiện câu lệnh

```sh
ceph mon add <host-name> {host-ip}
ceph-deploy mon add <ceph-node>
```

VD: ceph-deploy mon add client

Thu được kết quả
![image](https://user-images.githubusercontent.com/79830542/190119692-01c370e8-7c9d-47ad-8499-5583ecff31c7.png)

## <a name="2" >2. Destroy monitor</a>

```sh
ceph mon remove <host-name>
ceph-deploy mon destroy <ceph-node>
```

VD: ceph-deploy mon destroy client

Thu được kết quả như hình
![image](https://user-images.githubusercontent.com/79830542/190121155-2ff97bc2-3c14-436f-ac2e-a1876731dc32.png)

## <a name="3" >3. Tài liệu tham khảo</a>

1. [Red Hat guide](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/1.2.3/html/red_hat_ceph_administration_guide/managing_cluster_size)

2. [Docs Ceph](https://docs.ceph.com/projects/ceph-deploy/en/latest/mon.html#)
