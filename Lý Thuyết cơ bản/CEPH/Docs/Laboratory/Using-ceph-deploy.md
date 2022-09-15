# Nội dung chính
[I. Chuẩn bị](#I)
  - [1. IP planning](#I.1)
  - [2. Mô hình triển khai](#I.2)
  - [3. Môi trường LAB (3 Node)](#I.3)

[II. Tiến hành triển khai](#II)
  - [1. Các bước chuẩn bị trên từng Server](#II.1)
  - [2. Sử dụng Ceph-deploy để cài đặt](#II.2)
  - [3. Cấu hình dashboad cho ceph cluster](#II.3)

[III. Tài liệu tham khảo](#III)

____


# <a name="I" >I. Chuẩn bị</a>
## <a name="I.1" >1. IP planning</a>
![image](https://user-images.githubusercontent.com/79830542/189559706-f13aaf36-a784-480b-8cfd-7f9676620743.png)

## <a name="I.2" >2. Mô hình triển khai</a>
<p align="center">
  <img src="https://github.com/Phuc-gif051/ThucTap2022/blob/main/L%C3%BD%20Thuy%E1%BA%BFt%20c%C6%A1%20b%E1%BA%A3n/CEPH/Docs/Images/Mo%20hinh%20ceph%203%20node.drawio.png" width="750">
</p>

## <a name="I.3" >3. Môi trường LAB (3 Node)</a>
- Mô hình này sử dụng 3 server, trong đó:
- Host `ceph01` cài đặt `ceph-deploy`,`ceph-admin`, `ceph-mon`, `ceph-mgr`
- Host `ceph02` cài đặt `ceph-osd`, `ceph-mgr`, `ceph-mon`
- Host `ceph03` cài đặt `ceph-osd`, `ceph-mgr`, `ceph-mon`
- Mô hình khá cơ bản cho việc áp dụng vào môi trường Product
- CentOS7 - 64 bit
- 03: HDD, trong đó:
    - `vda`: sử dụng để cài OS
    - `vdb`,`vdc`: sử dụng làm OSD (nơi chứa dữ liệu)
- 03 NICs: 
    - `eth0`: dùng để kết nối internet và tải gói cài đặt
    - `eth1`: dùng để các trao đổi thông tin giữa các node Ceph, cũng là đường Client kết nối vào, ssh
    - `eth2`: dùng để đồng bộ dữ liệu giữa các OSD
- Phiên bản cài đặt : Ceph Nautilus

## <a name="I.4" >4. Mục tiêu bài lab</a>
- Sử dụng ceph-deploy để cài đặt được ceph bản nautilus 14.2.22 trên mô hình 3 node
- Khởi chạy được ceph-dashboard



# <a name="II" >II. Tiến hành triển khai</a>

## <a name="II.1" >1. Các bước chuẩn bị trên từng Server</a>

- Cài đặt NTPD 
```sh 
yum install chrony -y 
```

- Enable NTPD 
```sh 
systemctl start chronyd 
systemctl enable chronyd 
```

- Kiểm tra chronyd hoạt động 
```sh 
chronyc sources -v 
timedatectl
```

- Set hwclock 
```sh 
hwclock --systohc
```

- Đặt hostname
```sh
hostnamectl set-hostname ceph01
```

- Đặt IP cho các node, VD với node 1:
```sh 
echo "Setup IP eth0"
nmcli c modify eth0 ipv4.addresses 172.16.5.2/16
nmcli c modify eth0 ipv4.gateway 172.16.0.1
nmcli c modify eth0 ipv4.dns 8.8.8.8
nmcli c modify eth0 ipv4.method manual
nmcli con mod eth0 connection.autoconnect yes

echo "Setup IP eth1"
nmcli c modify eth1 ipv4.addresses 172.16.15.2/24
nmcli c modify eth1 ipv4.method manual
nmcli con mod eth1 connection.autoconnect yes

echo "Setup IP eth2"
nmcli c modify eth2 ipv4.addresses 172.16.16.2/24
nmcli c modify eth2 ipv4.method manual
nmcli con mod eth2 connection.autoconnect yes
```
- Cài đặt epel-relese
```sh
yum install epel-release -y
```

- Cài đặt CMD_log 
```sh 
curl -Lso- https://raw.githubusercontent.com/nhanhoadocs/scripts/master/Utilities/cmdlog.sh | bash
```

- Vô hiệu hóa Selinux
```sh
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
```

- Hoặc có thể disable firewall 
```sh 
sudo systemctl disable firewalld
sudo systemctl stop firewalld
```

⚠️:_Khi tắt firewalld và security linux thì cần phải có các biện pháp bảo mật khác tương đương hoặc cao hơn để đảm bảo cho cụm ceph trong môi trường production. Hoặc chỉ cần tắt security linux và thông báo mở port cho ceph hoạt động để giảm gánh nặng về việc triển khai bảo mật thay thế._

- Mở port cho Ceph trên Firewalld  
```sh 
# start enable
systemctl start firewalld
systemctl enable firewalld

# ceph-ansible
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=2003/tcp --permanent
sudo firewall-cmd --zone=public --add-port=4505-4506/tcp --permanent
sudo firewall-cmd --reload

# mon
sudo firewall-cmd --zone=public --add-port=6789/tcp --permanent
sudo firewall-cmd --reload

# osd
sudo firewall-cmd --zone=public --add-port=6800-7300/tcp --permanent
sudo firewall-cmd --reload

# rgw
sudo firewall-cmd --zone=public --add-port=7480/tcp --permanent
sudo firewall-cmd --reload

# mds
sudo firewall-cmd --zone=public --add-port=6800/tcp --permanent
sudo firewall-cmd --reload
```

- Bổ sung file hosts
```sh
cat << EOF >> /etc/hosts
172.16.15.2 ceph01
172.16.15.3 ceph02
172.16.15.4 ceph03
EOF
```
>trong bài lab này sử dụng eth1 để làm kết nối ssh bên trong cụm ceph, cũng là đường để client kết nối vào.

- Kiểm tra kết nối
```sh 
ping -c 10 ceph01
```
- Bổ sung user `cephuser`
```sh 
sudo useradd cephuser; echo 'mật-khẩu-tự-đặt' | passwd cephuser --stdin
```  
- Cấp quyền sudo cho `cephuser`
```sh
echo "cephuser ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cephuser
sudo chmod 0440 /etc/sudoers.d/cephuser
```
- Khai báo repo cho ceph nautilus

Thực hiện hiện khai báo repo cho ceph nautilus trên tất cả các node CEPH.

```sh
cat <<EOF> /etc/yum.repos.d/ceph.repo
[ceph]
name=Ceph packages for $basearch
baseurl=https://download.ceph.com/rpm-nautilus/el7/x86_64/
enabled=1
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-noarch]
name=Ceph noarch packages
baseurl=https://download.ceph.com/rpm-nautilus/el7/noarch
enabled=1
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-source]
name=Ceph source packages
baseurl=https://download.ceph.com/rpm-nautilus/el7/SRPMS
enabled=0
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc
EOF
```

- Cập nhật hệ thống và Khởi động lại máy
```sh
yum update -y
init 6
```

## <a name="II.2" >2. Sử dụng Ceph-deploy để cài đặt</a>

Các bước ở dưới được thực hiện toàn toàn trên Node `ceph01`
>node ceph01 được chọn làm node admin, sau này nếu có bất kỳ thao tác gì với cụm ceph thì sẽ thực hiện trên node ceph01.

- Cài đặt `python-setuptools`
```sh 
yum install python-setuptools -y
```

- Cài đặt `ceph-deploy`
```sh 
yum install ceph-deploy -y
```

- Kiểm tra cài đặt 
```sh 
ceph-deploy --version
```
>Kết quả như sau là đã cài đặt thành công ceph-deploy
```sh 
2.0.1
```

- Chuyển sang tài khoản cephuser
```sh
su - cephuser
```

- Tạo ssh key, sau đó copy sang các node còn lại, nhập mật khẩu của user cephuser đã tạo ở trên khi được hỏi tại màn hình. 
>Lưu ý không dùng sudo với lệnh ssh-keygen
```sh
ssh-keygen
```

Nhấn Enter để mặc định các tham số, bước này sẽ sinh ra private key và public key cho user cephuser. Sau đó tiến hành các lệnh dưới để copy public key sang các node.

Nhập mật khẩu của user cephuser tạo ở các node trước đó trong bước trên.
```sh
ssh-copy-id cephuser@ceph01
ssh-copy-id cephuser@ceph02
ssh-copy-id cephuser@ceph03
```

- Tạo thư mục chứa các file cấu hình khi cài đặt CEPH
```sh
cd ~
mkdir my-cluster
cd my-cluster
```

- Khai báo các node dùng để cài đặt cluser cluster. 

```sh
ceph-deploy new ceph01 ceph02 ceph03
```

- Kiểm tra lại thông tin folder `ceph-deploy`
```sh 
[cephuser@ceph01 ceph-deploy]# ls -lah
total 12K
drwxr-xr-x   2 root root   75 Jan 31 16:31 .
dr-xr-xr-x. 18 root root  243 Jan 31 16:29 ..
-rw-r--r--   1 root root 2.9K Jan 31 16:31 ceph-deploy-ceph.log
-rw-r--r--   1 root root  195 Jan 31 16:31 ceph.conf
-rw-------   1 root root   73 Jan 31 16:31 ceph.mon.keyring
[cephuser@ceph01 ceph-deploy]#
```

- `ceph.conf` : file config được tự động khởi tạo
- `ceph-deploy-ceph.log` : file log của toàn bộ thao tác đối với việc sử dụng lệnh `ceph-deploy`
- `ceph.mon.keyring` : Key monitoring được ceph sinh ra tự động để khởi tạo Cluster

- Chúng ta sẽ bổ sung thêm vào file `ceph.conf` một vài thông tin cơ bản như sau:
```sh
cat << EOF >> ceph.conf
osd pool default size = 3
osd pool default min size = 1
osd pool default pg num = 128
osd pool default pgp num = 128

osd crush chooseleaf type = 1

public network = 172.16.15.0/24
cluster network = 172.16.16.0/24
EOF
```
- Bổ sung thêm định nghĩa 
    + `public network` : Đường trao đổi thông tin giữa các node Ceph và cũng là đường client kết nối vào 
    + `cluster network` : Đường đồng bộ dữ liệu
- Bổ sung thêm `default size replicate`
- Bổ sung thêm `default pg num`

- Cài đặt ceph trên toàn bộ các node ceph
```sh
ceph-deploy install --release nautilus ceph01 ceph02 ceph03 
```

- Kiểm tra sau khi cài đặt trên cả 3 node
```sh 
ceph -v 
```
> Kết quả như sau là đã cài đặt thành công ceph trên node 
```sh 
 ceph version 14.2.22 (4f8fa0a0024755aae7d95567c63f11d6862d55be) nautilus (stable)
```

- Khởi tạo cluster với các node `mon` (Monitor-quản lý) dựa trên file `ceph.conf`
```sh
ceph-deploy mon create-initial
```

- Sau khi thực hiện lệnh phía trên sẽ sinh thêm ra 05 file : 
`ceph.bootstrap-mds.keyring`, `ceph.bootstrap-mgr.keyring`, `ceph.bootstrap-osd.keyring`, `ceph.client.admin.keyring` và `ceph.bootstrap-rgw.keyring`. Quan sát bằng lệnh `ll -alh`

```sh
[cephuser@ceph01 ceph-deploy]# ls -lah
total 348K
drwxr-xr-x   2 root root  244 Feb  1 11:40 .
dr-xr-xr-x. 18 root root  243 Feb  1 11:29 ..
-rw-r--r--   1 root root 258K Feb  1 11:40 ceph-deploy-ceph.log
-rw-------   1 root root  113 Feb  1 11:40 ceph.bootstrap-mds.keyring
-rw-------   1 root root  113 Feb  1 11:40 ceph.bootstrap-mgr.keyring
-rw-------   1 root root  113 Feb  1 11:40 ceph.bootstrap-osd.keyring
-rw-------   1 root root  113 Feb  1 11:40 ceph.bootstrap-rgw.keyring
-rw-------   1 root root  151 Feb  1 11:40 ceph.client.admin.keyring
-rw-r--r--   1 root root  195 Feb  1 11:29 ceph.conf
-rw-------   1 root root   73 Feb  1 11:29 ceph.mon.keyring
```

- Để node `ceph01`, `ceph02`, `ceph03` có thể thao tác với cluster chúng ta cần gán cho node quyền admin bằng cách bổ sung key `admin.keying` cho node

Thực hiện copy file `ceph.client.admin.keyring` sang các node trong cụm ceph cluster. File này sẽ được copy vào thư mục /etc/ceph/ trên các node.
```sh  
ceph-deploy admin ceph01 ceph02 ceph03
```

- Đứng trên node ceph01 phân quyền cho file /etc/ceph/ceph.client.admin.keyring cho cả 03 node.
```sh
ssh cephuser@ceph01 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'
ssh cephuser@ceph02 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'
ssh cephuser@ceph03 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'
```

- Khởi tạo MGR: Ceph-mgr là thành phần cài đặt yêu cầu cần khởi tạo từ bản luminous, có thể cài đặt trên nhiều node để cụm hoạt động theo cơ chế [`Active-Passive`](https://blog.cloud365.vn/linux/tong-quan-ve-cluster-p1/#che-%C4%91o-hoat-%C4%91ong)

```sh
ceph-deploy mgr create ceph01 ceph02
```

- Khởi tạo OSD: trên 2 node 02 và 03

```sh 
# ceph02 
ceph-deploy disk zap ceph02 /dev/vdb
ceph-deploy disk zap ceph02 /dev/vdc
ceph-deploy osd create --data /dev/vdb ceph02
ceph-deploy osd create --data /dev/vdc ceph02

# ceph03
ceph-deploy disk zap ceph03 /dev/vdb
ceph-deploy disk zap ceph03 /dev/vdc
ceph-deploy osd create --data /dev/vdb ceph03
ceph-deploy osd create --data /dev/vdc ceph03
```

- Kiểm tra lại kết quả
```sh
ceph osd tree
```

- Kiểm tra cài đặt 
```sh
[cephuser@ceph01 ceph-deploy]# ceph -s 
  cluster:
    id:     ba7c7fa1-4e55-450b-bc40-4cf122b28c27
    health: HEALTH_OK
 
  services:
    mon: 3 daemons, quorum ceph01,ceph02,ceph03 (age 3m)
    mgr: ceph01(active, since 1m), standbys: ceph02, ceph03
    osd: 4 osds: 4 up, 4 in
 
  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   0 B used, 0 B / 0 B avail
    pgs:    
```
## <a name="II.3" >3. Cấu hình dashboad cho ceph cluster</a>
- Ceph-dashboard là một thành phần thuộc ceph-mgr. 

Trong bản Nautilus thì thành phần dashboard được cả tiến khá lớn. Cung cấp nhiều quyền hạn thao tác với CEPH hơn các bản trước đó (thành phần này được đóng góp chính bởi team SUSE).

Thực hiện trên node ceph01 việc cài đặt này.

Trong bản ceph nautilus 14.2.3 (tính đến ngày 06.09.2019), khi cài ceph dashboard theo các cách cũ gặp một vài vấn đề, cách xử lý như sau.

Cài thêm các gói bổ trợ trước khi cài
```sh
sudo yum install -y python-jwt python-routes
sudo rpm -Uvh http://download.ceph.com/rpm-nautilus/el7/noarch/ceph-grafana-dashboards-14.2.22-0.el7.noarch.rpm
sudo rpm -Uvh http://download.ceph.com/rpm-nautilus/el7/noarch/ceph-mgr-dashboard-14.2.22-0.el7.noarch.rpm
```

- Thực hiện kích hoạt ceph-dashboard
```sh
ceph mgr module enable dashboard --force
```
- Tạo cert cho ceph-dashboad
```sh
sudo ceph dashboard create-self-signed-cert 
```
> Kết quả trả về dòng Self-signed certificate created là thành công.

- Tạo tài khoản cho ceph-dashboard, trong hướng dẫn này tạo tài khoản tên là admin và mật khẩu được lấy từ trong file /opt/secretkey

>do đã thay đổi cơ chế hoạt động nên mật khẩu cần được lấy từ 1 file do người người dùng tạo ra.
  + tạo mật khẩu của riêng bạn và lưu lại
```sh
vi /opt/secretkey
```

  + tạo tài khoản cho ceph-dashboard
  ```sh
  ceph dashboard ac-user-create admin -i /opt/secretkey administrator 
  ```
  + Kết quả trả về có dạng
  ```sh
  {"username": "admin", "lastUpdate": 1567415960, "name": null, "roles": ["administrator"], "password":
  "$2b$12$QhFs2Yo9KTICIqT8v5xLC.kRCjzuLyXqyzBQVQ4MwQhDbSLKni6pC", "email": null}
  ```
  + Kiểm tra xem ceph-dashboard đã được cài đặt thành công hay chưa
  ```sh
  ceph mgr services 
  ```
  + Kết quả trả về có dạng
  ```sh
  {
    "dashboard": "https://ceph01:8443/"
}
  ```
Trước khi tiến hành đăng nhập vào web, có thể kiểm tra trạng thái cluser bằng lệnh `ceph -s` . Ta sẽ có kết quả trạng thái là HEALTH-OK.

Kết quả sẽ là địa chỉ truy cập ceph-dashboad, ta có thể vào bằng địa chỉ IP thay vì hostname, https://Dia-Chi-IP-CEPH01:8443. Ta có màn hình đăng nhập như sau:
<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/190055220-9ff67601-2ad4-41d9-95f6-9b89e176cf1e.png" width="750">
</p>

Đăng nhập bằng tài khoản và mật khẩu đã tạo, ta được như sau:
<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/190055461-e28df64c-7a5e-4bd1-a3ec-5c5838d5d0ea.png" width="750">
</p>

# <a name="III" >III. Tài liệu tham khảo</a>

1. [Bài viết trên github](https://github.com/uncelvel/tutorial-ceph/blob/master/docs/setup/ceph-nautilus.md)
2. [Bài viết trên web cloud365](https://news.cloud365.vn/ceph-lab-phan1-huong-dan-cai-dat-ceph-nautilus-tren-centos7/)

date accesd 14/09/2022
