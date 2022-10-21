_Đây là cách thêm module bằng cách cài đặt lại Nginx từ source, trước khi tiến hành bạn có thể cần back up lại các file config cho website trước đó. Hoặc có thể tham khảo thêm gợi ý ở dưới_

https://www.phusionpassenger.com/library/install/nginx/install_as_nginx_module.html

___
## Nội dung chính
[1. Add module ngx_pagespeed](#1)

[2. Add module RTMP](#2)

[3. Install](#3)

[4. Reference](#4)
___




## <a name="1" >1. add module ngx_pagespeed</a>

yum install -y perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel pcre-devel wget

khai bao cac phien ban can cai dat
NPS_VERSION=1.13.35.2-stable
NGINX_VERSION=1.22.0

tai ve

wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}.zip

giai nen

tar -xvzf nginx-${NGINX_VERSION}.tar.gz
unzip v${NPS_VERSION}.zip

di chuyển vào thư mục page speed vừa giải nén:
```sh
cd incubator-pagespeed-ngx-1.13.35.2-stable/
```sh```

tải về thư viện cần thiết, thực hiện từng câu lệnh theo thứ tự:
```sh
 - psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz

 - [ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)

 - wget ${psol_url}

 - tar -xzvf $(basename ${psol_url})
```

di chuyển về thư mục của nginx:

```sh
cd /root/nginx-1.22.0
```

Add module:
```sh
./configure --add-module=$HOME/incubator-pagespeed-ngx-1.13.35.2-stable --user=nobody --group=nobody --pid-path=/var/run/nginx.pid ${PS_NGX_EXTRA_FLAGS}
```

Tao file script cho ngx_pagespeed. Ma nguon lay [tai day](https://www.nginx.com/nginx-wiki/build/dirhtml/start/topics/examples/redhatnginxinit/)
```sh
vi /etc/init.d/nginx
```

Thay đổi quyền thực thi cho script vừa tạo:
```sh
chmod +x /etc/init.d/nginx
```

tao thu muc cache cho mudule
```sh
mkdir -pv /var/cache/nginx/ngx_pagespeed_cache
```

thay quyen cua thu muc 

```sh
chown -R nginx:nginx /var/cache/nginx/ngx_pagespeed_cache
```

them doan ma sau vao trong file conf, ben trong khoi server ma ban muon cai thien hieu suat tai trang {...}

```sh
##
# Pagespeed main settings

pagespeed on;
pagespeed FileCachePath /var/ngx_pagespeed_cache;

# Ensure requests for pagespeed optimized resources go to the pagespeed
# handler and no extraneous headers get set.

location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" { add_header "" ""; }
location ~ "^/ngx_pagespeed_static/" { }
location ~ "^/ngx_pagespeed_beacon" { }
```

## <a name="2" >2. Cai them module RTMP phuc vu cho viec truyen tai da phuong tien</a>

tai xuong ma nguon tu github, hay nho duong dan den ma nguon nay khi tai ve. Thuong la luu chung voi cac tep da tai xuong de cai nginx

```sh
git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git
```

Tai xuong cac thu vien can thiet va giai nen chung:
```sh
wget https://www.zlib.net/zlib-1.2.12.tar.gz && tar xf zlib-1.2.12.tar.gz
wget https://www.openssl.org/source/openssl-1.1.1o.tar.gz && tar xf openssl-1.1.1o.tar.gz
wget https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz && tar xf pcre-8.45.tar.gz

```

Di chuyen vao thu muc nginx-1.22.0

```sh
cd nginx-1.22.0
```

Copy tep `configure` vao thu muc `auto`

```sh
cp configure auto
```

Add them module cho nginx

```sh
./auto/configure --add-module=../nginx-rtmp-module --with-pcre=../pcre-8.45 --with-openssl=../openssl-1.1.1o
```

## <a name="3" >3. Install</a>
Sau khi thêm các module vào mã nguồn, ta cần tiến hành cài đặt lại Nginx:

```sh
make & make install
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
```sh```

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


khoi dong lai dich vu

```sh
systemctl restart nginx
```

Test:
curl -I -p http://localhost | grep X-Page-Speed

thaasy dich vu X-Page-Speed la thanh cong

# <a name="4" >Reference</a>

https://www.vultr.com/docs/install-nginx-with-ngx-pagespeed-on-centos-7/

https://www.howtoforge.com/tutorial/how-to-install-nginx-with-rtmp-module-on-centos/

https://viblo.asia/p/streaming-videos-server-su-dung-nginx-rtmp-va-hls-maGK7q4Llj2

https://www.youtube.com/watch?v=Js1OlvRNsdI

https://www.youtube.com/watch?v=eyEHPbQdqnY
