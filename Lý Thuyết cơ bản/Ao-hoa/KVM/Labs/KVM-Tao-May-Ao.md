# Tìm hiểu tạo máy ảo

## 1. Cài đặt KVM - Tạo máy ảo với file ISO bằng virt-install

- Kiểm tra việc hỗ trợ ảo hóa của CPU:

```sh
egrep -c "svm|vmx" /proc/cpuinfo
```

>Kết quả trả về khác 0 thì CPU hỗ trợ ảo hóa.

- Cài các gói cần thiết:

```sh
yum install qemu-kvm libvirt virt-install virt-manager virt-install -y
```

Kiểm tra để chắc chắn rằng KVM đã được cài đặt

```sh
# lsmod | grep kvm
kvm_intel             204800  0
kvm                   593920  1 kvm_intel
irqbypass              16384  1 kvm
```

Đối với bản Minimal để dùng được công cụ đồ họa `virt-manager` người dùng phải cài đặt gói `x-window` bằng câu lệnh

```sh
yum install "@X Window System" xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils -y
```

Start dịch vụ libvirt và cho nó khởi động cùng hệ thống

```sh
systemctl start libvirtd
systemctl enable libvirtd
```


- Tạo máy ảo với câu lệnh

```sh
virt-install \
--name ubuntu18.04-1 \
--ram 2048 \
--disk path=/var/lib/libvirt/images/ubuntu1.img,size=10 \
--vcpus 2 \
--network bridge=virbr0 \
--graphics vnc \
--console pty,target_type=serial \
--cdrom=/home/lamth/Downloads/ubuntu-18.04.3-desktop-amd64.iso
```

- Trong đó:
  - `virt-install` : Câu lệnh thực hiện gọi chức năng virt-install (require)
  - `--name ubuntu18.04-1` : Khai báo tên cho VM (require)
  - `--ram 2048`: Khai báo kích thước RAM(Mb) cung cấp cho VM (require)
  - `--disk path=/var/lib/libvirt/images/ubuntu1.img,size=10` : Khai báo đường dẫn của file storage của VM và kích cỡ của nó (Gb)(Kích cỡ là bắt buộc nếu image chưa tồn tại)
  - `--vcpus 2` : Khai báo số lượng CPU ảo cung cấp cho VM (require)
  - `--network bridge=virbr0` : Khai báo card mạng cho VM (option)
  - `--graphics vnc` : Khai báo cho phép tiến hành cài đặt cùng với giao diện (require)
  - `--console pty,target_type=serial` : Khai báo loại CLI của hệ điều hành cài đặt nếu như sử dụng CLI (option)
  - `--cdrom=/home/lamth/....iso` : Khai báo đường dẫn chứa của file cài đặt hệ điều hành (*.iso) (require)

## 2. Tạo máy ảo từ file disk image có sẵn

- Có thể tạo máy ảo từ các disk image có sẵn, đã được cài hệ điều hành trước đó, có thể tải từ một số trang cung cấp cloud image như <https://cloud-images.ubuntu.com/>
- Để tạo máy ảo từ image có sẵn, sử dụng câu lệnh:

```sh
virt-install \
    --name template \
    --ram 512 \
    --vcpus 1 \
    --disk path=/var/kvm/images/template.img --import --force
```

Trong đó:
virt-install : Câu lệnh thực hiện gọi chức năng virt-install (require)
--name template : Khai báo tên của VM tạo ra là template
--ram 512 : Khai báo kích thước RAM của VM là 512 Mb
--disk path=/var/kvm/images/template.img --import --force : Khai báo đường dẫn chứa file *.img để sử dụng cho VMs

## 3. Tạo vm bằng file xml

- Thông thường khi tạo bất kỳ máy ảo nào thì đều sinh ra một file cấu hình dạng .xml nằm trong thư mục /etc/libvirt/qemu. File xml này chứ thông tin về cấu hình của máy ảo như cpu, ram, mạng, lưu trữ, snapshot,....
- Có thể tạo vm từ file *.xml có sẵn trong /etc/libvirt/qemu sau khi chỉnh sửa theo yêu cầu, hoặc có thể tự tạo một file .xml mới và thêm những cấu hình cần thiết để tạo được một máy ảo.

- Để tạo máy ảo từ file xml, trước tiên cần tạo một disk image trước:

```sh
cd /var/lib/libvirt/images
qemu-img create -f qcow2 test.qcow2 10G
```

Lệnh trên tạo disk image test.qcow2 dưới định dạng qcow2(`-f qcow2`) và có kích thước là 10G.

- Sau khi tạo được ổ cứng cho máy ảo thì cần chỉnh sửa hoặc thêm cấu hình trong file xml để sử dụng ổ cứng đó cho vm:

```xml
 ...
 	<disk type='file' device='disk'>
 		<driver name='qemu' type='qcow2'/>
 		<source file='/var/lib/libvirt/images/test.qcow2'/>
 		...
 	</disk>
 ...
```

- Sau khi tạo được disk và file xml, có hai cách để tạo máy ảo:
  - `virsh create test.qcow2` - Tạo ra và chạy một máy ảo và máy ảo sẽ tồn tại đến khi host tắt.
  - `virsh define test.qcow2` - Tạo nhưng không chạy ngay máy ảo, máy ảo tồn tại trên host cho đến khi có lệnh undefine.


## Tài liệu tham khảo

[Tạo với giao diện đồ họa của virt-manager](https://github.com/nhanhoadocs/thuctapsinh/blob/master/NiemDT/KVM/docs/Install-va-tao-may-ao-voi-KVM.md)

<https://github.com/nhanhoadocs/thuctapsinh/blob/master/NiemDT/KVM/docs/Install-va-tao-may-ao-voi-KVM.md>

<https://github.com/lamth/Report-MDT/blob/master/KVM/docs/10.Create-Guest.md>

<https://www.cyberciti.biz/faq/how-to-install-kvm-on-centos-7-rhel-7-headless-server/>

<https://blog.cloud365.vn/linux/huong-dan-cai-dat-kvm-tren-centos7/>

<https://www.cyberciti.biz/faq/how-to-install-kvm-on-centos-7-rhel-7-headless-server/>

