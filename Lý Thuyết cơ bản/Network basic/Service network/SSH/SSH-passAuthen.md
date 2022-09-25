Chứng thực bằng username và password là cách phổ biến nhất để định danh người dùng. Mặc định cấu hình đã cho phép chứng thực bằng password, tuy nhiên ta có thể cấu hình thêm các tùy chọn khác bằng cách chỉnh sửa file cấu hình.

	# vi /etc/ssh/sshd_config 
	
Cổng truy cập 

	Port 22
	
Bật/tắt cho phép root đăng nhập (yes/no)

	PermitRootLogin yes
	
Không chấp nhận tài khoản có password để trống 

	PermitEmptyPassword no

Phải nhập password xác thực

	PasswordAuthentication yes

Cấm nhóm người dùng

	DenyGroups g1 g2
	
Cho phép nhóm người dùng
	
	AllowGroups g1 g2
	
Cho phép người dùng

	AllowUsers u1 u2 
	
Sau khi sửa file cấu hình, ta phải restart lại dịch vụ 

	# systemctl restart sshd
	
Thực hiện tạo key trên máy client hoặc server

	# ssh-keygen -t rsa -b 1024
Sử dụng đường dẫn mặc định để tạo file. Nếu bạn muốn bảo mật hơn, hãy nhập passphrase còn không thì enter.

<img src="https://user-images.githubusercontent.com/79830542/192147248-3314c759-eeb1-4323-ac43-69c02867f8b9.png">

Cặp key sẽ được tạo trong thư mục /root/.ssh :

<img src="https://user-images.githubusercontent.com/79830542/192147265-6a78ba40-59d3-4b15-bb3b-a766a43c86cf.png">

Private-key là `id_rsa` và public-key là `id_rsa.pub`

Copy key sang máy còn lại 
	
	# ssh-copy-id username@<IP-or-hostname>
	
Sẽ có yêu cầu nhập mật khẩu của `user name` mà ta muốn copy key. Nhập mật khẩu để xác nhận. 
	


	
