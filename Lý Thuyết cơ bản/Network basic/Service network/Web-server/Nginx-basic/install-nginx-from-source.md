
## <a name="" >Install-nginx-from-source</a>
[1. Chuan bi](#1)

[2. Cai dat](#2)

[3. Tai lieu tham khao](#IV)
## <a name="1" >1. Chuan bi</a>

Cai dat cac goi can thiet, tat firewalld

```sh
systemctl stop firewalld
systemctl disable firewalld
yum install epel-release -y
yum groupinstall -y 'Development Tools'
yum install -y perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel pcre-devel wget
yum -y update
```

Tai ve cac tep can thiet. Nen nho duong dan den cac tep nay (thuong la luu tai thu muc goc cua tai khoan dang dang nhap, neu login voi nguoi dung root thi se la /root)

```sh
wget https://nginx.org/download/nginx-1.22.0.tar.gz
wget https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz
wget https://www.zlib.net/zlib-1.2.12.tar.gz
wget https://www.openssl.org/source/openssl-1.1.1o.tar.gz
```

Giai nen cac tep vua tai ve

```sh
tar xf nginx-1.22.0.tar.gz
tar xf openssl-1.1.1o.tar.gz
tar xf pcre-8.45.tar.gz
tar xf zlib-1.2.12.tar.gz
```


## <a name="2" >2. Tien hanh cai dat</a>

Di chuyen sang thu muc nginx-1.22.0 vua giai nen de tien hanh cai dat

```sh
cd nginx-1.22.0
```

chay cac cau lenh sau de tiesn hanh cai dat nginx 

```sh
./configure --prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--modules-path=/usr/lib64/nginx/modules \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--user=nginx \
--group=nginx \
--build=CentOS \
--builddir=nginx-1.22.0 \
--with-select_module \
--with-poll_module \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module=dynamic \
--with-http_image_filter_module=dynamic \
--with-http_geoip_module=dynamic \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \
--http-log-path=/var/log/nginx/access.log \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--with-mail=dynamic \
--with-mail_ssl_module \
--with-stream=dynamic \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_geoip_module=dynamic \
--with-stream_ssl_preread_module \
--with-compat \
--with-pcre=../pcre-8.45 \
--with-pcre-jit \
--with-zlib=../zlib-1.2.12 \
--with-openssl=../openssl-1.1.1o \
--with-openssl-opt=no-nextprotoneg \
--with-debug
make
make install
```

Thiết lập file cấu hình cho Nginx


- Tạo file shortcut /etc/nginx/modules

```sh
ln -s /usr/lib64/nginx/modules /etc/nginx/modules
```

- tạo thêm user, user này không có khả năng loggin

```sh
adduser --system --no-create-home --user-group -s /sbin/nologin nginx
```

- tạo file chứa cache

```sh
mkdir -p /var/cache/nginx
```

- test web server nginx hoạt động được chưa

```sh
nginx -t
```

Thiết lập dịch vụ nginx cho máy Centos 7

```sh
vi /usr/lib/systemd/system/nginx.service
```

Nhap vao noi dung sau:

```sh
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

Luu lai va thoat.

Khởi động dịch vụ Nginx

```sh
systemctl start nginx
```

Kiem tra trang thai

```sh
systemctl status nginx
```

Co the bat khoi dong cung he thong hoac khong.

```sh
systemctl enable nginx
```

Kiểm tra port

```sh
netstat -ltunp
```

# <a name="IV" >Reference</a>

https://www.howtoforge.com/tutorial/how-to-install-nginx-with-rtmp-module-on-centos/

https://dinhducthanh.com/cai-dat-nginx-tu-source/

Date acced: 11/10/2022


