## Cài đặt vsftpd trên CentOS 7

### Update và install gói vsftpd 

	# yum check-update
	# yum -y install vsftpd

### Cấu hình

Để khôi phục lại file cấu hình mặc đinh nếu ta cấu hình sai mà không rõ biết cách sửa thì ta cần backup file cấu hình

	# cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
	
Bắt đầu cấu hình :

	# vi /etc/vsftpd/vsftpd.conf
	
Một số cấu hình khuyến cáo :

	anonymous_enable=NO 
	ascii_upload_enable=YES
	ascii_download_enable=YES
	chroot_local_user=YES
	allow_writeable_chroot=YES
	pasv_enable=Yes
	pasv_min_port=40000
	pasv_max_port=40100
	
### Restart lại vsftpd

	# systemctl restart vsftpd
	
### Thêm dịch vụ FTP trong firewall để cho phép mở cổng ftp 

	# firewall-cmd --permanent --add-service=ftp
	# firewall-cmd --reload
	
Nếu thấy phức tạp, trong quá trình luyện tập bạn có thể stop firewall bằng lệnh 

	# systemctl stop firewalld
	
### Tạo user 

	# groupadd ftpaccess
	# useradd -m testFTP -s /sbin/nologin -g ftpaccess
	# passwd testFTP
  
### Thay đổi quyền cho thư mục
	# chown root /home/testFTP
	# chmod 750 /home/testFTP
  
  
### Phân quyền cho thư mục được phép truy cập	
	# mkdir /home/locvu/www
	# chown testFTP:ftpaccess /home/locvu/www

	
	
### THam khảo 

http://www.krizna.com/centos/setup-ftp-server-centos-7-vsftp/
