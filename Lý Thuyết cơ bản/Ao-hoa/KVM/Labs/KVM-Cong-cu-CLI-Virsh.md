# Hướng dẫn sử dụng vish và virt-install.

[1. Virsh là gì?](#1)

[2. Một số lệnh virsh cơ bản.](#2)

[3 Các câu lệnh Snapshot](#3)

[4. Một số lệnh xem các thông số của VM](#4)

[5. Sử dụng virt-install](#5)

---

<a name="1"></a>

## 1. Virsh là gì

Libvirt là một bộ các phần mềm mà cung cấp các cách thuận tiện để quản lý máy ảo và các chức năng của ảo hóa. Những phần mềm này bao gồm một thư viện API daemon (libvirtd) và các gói tiện tích giao diện dòng lệnh (virsh).


Virsh là một tools kiểm soát và thực hiện hành động với các máy ảo.

<a name="2"></a>

## 2. Một số lệnh virsh cơ bản

### 2.1 Hiện tất cả máy ảo đã được cài đặt

```sh
virsh list --all
```

```sh
root@iou:/etc/libvirt/qemu# virsh list --all
error: unsupported option '--all'. See --help.
root@iou:/etc/libvirt/qemu# virsh list --all
 Id   Name          State
------------------------------
 8    centos7.0     shut off
```

### 2.2 Khởi động máy ảo

```sh
virsh start <ten may ao>
```

```sh
root@iou:/etc/libvirt/qemu# virsh start centos7.0
Domain thanhbc started
```

### 2.3 Hiện thị các máy ảo đang hoạt động

```sh
virsh list
```

```sh
root@iou:/etc/libvirt/qemu# virsh list
 Id   Name      State
-------------------------
 3    thanhbc   running
```

### 2.4 Tắt 1 máy ảo

```sh
virsh shutdown <ten may ao>
```

```sh
root@iou:/etc/libvirt/qemu# virsh shutdown centos7.0
Domain centos7.0 is being shutdown
```

### 2.5 Xem thông tin 1 máy ảo

```sh
virsh dominfo <ten may ao>
```

```sh
[root@centos7 networks]# virsh dominfo centos7.0
Id:             8
Name:           centos7.0
UUID:           f1770972-c285-4865-b338-a6ca8da87882
OS Type:        hvm
State:          running
CPU(s):         1
CPU time:       86.1s
Max memory:     1048576 KiB
Used memory:    1048576 KiB
Persistent:     yes
Autostart:      disable
Managed save:   no
Security model: none
Security DOI:   0

[root@centos7 networks]#

```

### 2.6 Chỉnh sưả thông số  của máy ảo

```sh
virsh edit <ten may ao>
```

Ta co thể chỉnh sửa thông số cpu, ram, network...

Sau khi chỉnh sửa ta phải sử dụng lệnh virsh define để các thay đổi được cập nhật.

```sh
virsh define <tên máy ảo>
```

### 2.7 Xóa một máy ảo.

```sh
virsh destroy <tên máy ảo>
virsh undefine <tên may ao>
```

sau đó xóa file images của máy ảo. Nên kiểm tra đường dẫn đến file img. Mặc định được lưu tại: `/var/lib/libvirt/images/`. Hoặc sẽ được lưu tại nơi lưu trữ file ISO dùng để cài đặt.

```sh
rm -rf /kvm/centos7.0.img
```

Sau khi xóa có thể kiểm tra lại với lệnh:

```sh
virsh list --all
```

### 2.8 Clone 1 máy ảo

```sh
virt-clone \
> --original=centos7.0 \
> --name=centos7.0-clone \
> --file=/var/kvm/images/centos7.0-clone.img
```

<a name="3"></a>

## 3 Các câu lệnh Snapshot

### 3.1 Xem các option trong snapshot

Ta sử dụng câu lệnh để xem các option.

```sh
virsh --help | grep snapshot
```

```sh
[root@centos7 networks]# virsh --help | grep snapshot
    iface-begin                    create a snapshot of current interfaces settings, which can be later committed (iface-commit) or restored (iface-rollback)
 Snapshot (help keyword 'snapshot')
    snapshot-create                Create a snapshot from XML
    snapshot-create-as             Create a snapshot from a set of args
    snapshot-current               Get or set the current snapshot
    snapshot-delete                Delete a domain snapshot
    snapshot-dumpxml               Dump XML for a domain snapshot
    snapshot-edit                  edit XML for a snapshot
    snapshot-info                  snapshot information
    snapshot-list                  List snapshots for a domain
    snapshot-parent                Get the name of the parent of a snapshot
    snapshot-revert                Revert a domain to a snapshot
[root@centos7 networks]#

```

### 3.2 Tạo mới một snapshot

```sh
virsh snapshot-create-as --domain centos7.0 --name snp-centos7.0 --decription "ban snapshot 01"
```

```sh
root@iou:/var/lib/libvirt/images# virsh snapshot-create-as --domain centos7.0  --name snp-centost7.0  --description "bản snapshot 01"
Domain snapshot snp-centost7.0 created
```

### 3.3 Kiểm tra xem đã tạo thành công chưa

```sh
virsh snapshot-list centos7.0
```


<a name="4"></a>

## 4. Một số lệnh xem các thông số của VM

### 4.1 Xem thông tin về file disk của VM

Câu lệnh xem thông tin về file disk của VM.

```sh
qemu-img info /var/lib/libvirt/images/centos7-test.qcow2
```

```sh
[root@client mnt]# qemu-img info /mnt/centos7.0.qcow2
image: /mnt/centos7.0.qcow2
file format: qcow2
virtual size: 10G (10737418240 bytes)
disk size: 1.8G
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: true
[root@client mnt]#
```

### 4.2 Xem thông tin cơ bản của VM

Câu lệnh xem thông tin cơ bản của VM

```sh
virsh dominfo centos7.0
```

```sh
[root@centos7 networks]# virsh dominfo centos7.0
Id:             8
Name:           centos7.0
UUID:           f1770972-c285-4865-b338-a6ca8da87882
OS Type:        hvm
State:          running
CPU(s):         1
CPU time:       99.5s
Max memory:     1048576 KiB
Used memory:    1048576 KiB
Persistent:     yes
Autostart:      disable
Managed save:   no
Security model: none
Security DOI:   0

[root@centos7 networks]#

```


### 4.3 Kiểm tra các cổng của 1 VM

Câu lệnh kiểm tra các cổng của 1 VM

```sh
virsh domiflist centos7.0
```

```sh
[root@centos7 networks]# virsh domiflist centos7.0
Interface  Type       Source     Model       MAC
-------------------------------------------------------
vnet0      bridge     br-ex      virtio      52:54:00:c1:da:ad

[root@centos7 networks]#

```

<a name="5"></a>

## 5. Sử dụng virt-install

### 5.1 Khởi tạo một máy ảo mới

#### 5.1.1 Tạo VM bằng file **iso**

Ta sử dụng câu lệnh có các option cơ bản.

```sh
root@iou:/home/buithanh/Documents/he_dieu_hanh# virt-install \
--name=Centos7-test \
--vcpus=1 \
--memory=1024 \
--cdrom=centos7-64.iso \
--disk=/var/lib/libvirt/images/centos7-test.qcow2,size=10 \
--os-variant=rhel7 \
--network bridge=virbr1
```

Trong đó:

- --name đặt tên cho máy ảo
- --vcpus là tổng số CPU tạo cho máy ảo
- --memory chỉ ra dung lượng RAM cho máy ảo (tính bằng MB)
- --cdrom chỉ ra đường dẫn đến file ISO. Nếu muốn boot bằng cách khác ta dùng option --locaion sau đó chỉ ra đường dẫn đến file (có thể là đường dẫn trên internet).
- --disk chỉ ra vị trí lưu disk của máy ảo. size chỉ ra dung lượng disk của máy ảo(tính bằng GB)
- --os-variant chỉ ra kiểu của HĐH của máy ảo đang tạo. Option này có thể chỉ ra hoặc không nhưng nên sử dụng nó vì nó sẽ cải thiện hiệu năng của máy ảo. Nếu bạn không biết HĐH hành của mình thuộc loại nào bạn có thể tìm kiếm thông tin bằng cách dùng lệnh osinfo-query os
- --network chỉ ra cách kết nối mạng của máy ảo. Trên đây là một số option cơ bản để tạo máy ảo. Bạn có thể tìm hiểu thêm bằng cách sử dụng lệnh virt-install --help

## Tai lieu tham khao

`virsh --help`

<https://github.com/thanh474/thuc-tap/edit/master/KVM/tim-hieu-lenh-virsh.md>



