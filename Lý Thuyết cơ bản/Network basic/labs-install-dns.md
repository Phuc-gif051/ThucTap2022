<a name="mo-hinh" ></a>
## Mô hình 

- Primary (Master) DNS Server:
    + OS: CentOS 7
    + IP: 172.16.15.5/24 & 172.16.5.5/16
    + Tắt firewalld và selinux 
- Client:
    + OS: CentOS 7, Window 10
    + IP: 172.16.5.4/16, 172.16.5.14/16

- Bài lab này tận dụng dashboard của ceph để làm ví dụ minh hoạ.

<a name="install" ></a>
## Cài đặt DNS server 

- Install bind9

    ``yum install bind bind-utils -y``

- Chỉnh sửa file conf

    ``vi /etc/named.conf``


<a name="config" ></a>
- Sửa theo file cấu hình này:

```
//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
	listen-on port 53 { 172.16.15.5;};
	#listen-on-v6 port 53 { ::1; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	allow-query     { 172.16.15.0/24; 172.16.0.0/16;};

	/* 
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to enable 
	   recursion. 
	 - If your recursive DNS server has a public IP address, you MUST enable access 
	   control to limit queries to your legitimate users. Failing to do so will
	   cause your server to become part of large scale DNS amplification 
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface 
	*/
	recursion yes;

	dnssec-enable yes;
	dnssec-validation yes;

	/* Path to ISC DLV key */
	bindkeys-file "/etc/named.iscdlv.key";

	managed-keys-directory "/var/named/dynamic";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

#zone "." IN {
#	type hint;
#	file "named.ca";
#};

zone "lab" IN {
type master;
file "forward.com";
allow-update { none; };
};

zone "172.in-addr.arpa" IN {
type master;
file "reverse.com";
allow-update { none; };
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";

```

<a name="set-database" ></a>
- Tạo cở sở dữ liệu cho zone `forward`: đây là CSDL cho việc dịch từ tên miền sang địa chỉ IP

``vi /var/named/forward.com``

Thêm các dòng sau:

```sh 
$TTL 86400
@   IN  SOA     server.lab. root.server.lab. (
        2022091501  ;Serial
        3600        ;Refresh
        1800        ;Retry
        604800      ;Expire
        86400       ;Minimum TTL
)
@       IN  NS          server.lab.
@       IN  A           172.16.15.3
@       IN  A           172.16.5.5
@       IN  A           172.16.15.4
ceph02        IN  A     172.16.15.3
server        IN  A     172.16.5.5
ceph03        IN  A     172.16.15.4

```

 -  Tạo cơ sở dữ liệu cho file `reverse`: đây là CSDL để dịch ngược từ địa chỉ IP sang tên miền.

``vi /var/named/reverse.com``

Thêm các dòng sau:

```sh
$TTL 86400
@   IN  SOA     server.lab. root.server.lab. (
        2022091501  ;Serial
        3600        ;Refresh
        1800        ;Retry
        604800      ;Expire
        86400       ;Minimum TTL
)
@       IN  NS          client.lab.
@       IN  PTR         lab.
server           IN  A   172.16.5.5
ceph02           IN  A   172.16.15.3
ceph03           IN  A   172.16.15.4
16.15.3     IN  PTR      ceph02.lab.
16.15.4     IN  PTR      ceph03.lab.
16.5.5      IN  PTR      server.lab.

```

- Khởi động service DNS

```sh
systemctl enable named
systemctl start named
```

- Tắt firewalld và selinux 

```sh
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config
setenforce 0

systemctl disable firewalld
systemctl stop firewalld
```

### <a name="check" >Kiểm tra lỗi cấu hình DNS nếu có</a>

- Kiểm tra file config `named.conf`
   - Kiểm tra tập tin cấu hình Bind: `named-checkconf /etc/named.conf`
   - Nếu nó không trả về lỗi nào thì tập tin cấu hình của bạn đã được cấu hình chính xác

- Kiểm tra Forward Zone: `named-checkzone ceph02.lab /var/named/forward.com`. Nếu kết quả xuất hiện như bên dưới nghĩa là phần cấu hình Forward Zone chúng ta đã cấu hình chính xác.
- ![image](https://user-images.githubusercontent.com/79830542/192185950-e4149650-3ccf-4743-a725-32daadb60dcb.png)

- Kiểm tra Reverse Zone: `named-checkzone ceph02.lab /var/named/reverse.com`. Nếu kết quả xuất hiện như bên dưới nghĩa là phần cấu hìnhReverse Zone chúng ta đã cấu hình chính xác.
- ![image](https://user-images.githubusercontent.com/79830542/192186215-4b5b999e-a278-47f6-9167-aaaddb31b5e6.png)

_Cấu hình trên server cơ bản hoàn tất. Chuyển sang các máy client_    


<a name="client" >Trỏ DNS của client về DNS server</a>

Trên CentOS 7:
- Sửa trong file config card mạng với câu lệnh: `vi /etc/sysconfig/network-scripts/ifcfg-<tên-card-mạng>`
- Thêm dòng sau: `DNS1=172.16.5.5`
- Mở tập tin /etc/resolv.conf: `vi /etc/resolv.conf`
- Thêm nội dung sau: `nameserver      172.16.5.5`

Trên Window 10:
- Chỉnh cấu hình mạng về static để có thể chỉ định IP và DNS cho máy.
- Thêm địa chỉ IP của DNS mà ta vừa cấu hình: 172.16.5.5 
https://vietnetwork.vn/routers-switches/cai-dat-va-cau-hinh-dns-server-tren-centos-7/

https://github.com/MinhKMA/DNS_note/blob/master/labs/dns_forwarder.md
